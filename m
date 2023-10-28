Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE57DA6CD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 14:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJ1MAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 08:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1MAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 08:00:03 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F0AE5;
        Sat, 28 Oct 2023 05:00:00 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-3b2ea7cc821so2013601b6e.1;
        Sat, 28 Oct 2023 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698494400; x=1699099200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+PiSBO3Y1WPsVw7wAvcXWqkwkpWT4KTgGbs+zAcx7ow=;
        b=NOCDrz1rOwfdZArrbnU6OvzfDNA9Ra4sLxqWLlUgxnZ71ZV+MZiqjYu5WpD6qYAcvi
         6ig+BkoTRjN84Wn7RphSjarh1zpokQz2Wj/njppM78zueJ+ZaqrvoYlw33S+CpwUgBan
         Ak3dFRksFHIHRBFURFMgJiahfNBdUGyDIb7vzHAF99Sr5veONiI0WnpmEFNItRMKLnIb
         66fW7Gv8P/mQtEZncjvOBzrlYS9dDgTAh9WZqPlfNSKKHpPSKHhrzkq08IRVbYwrRvj+
         VUP5RV9due2UwInk/vR0DfHuFh1aCEpH9vQ3uI71PYmYgWtI54yFMwkKLcSLHcFCuF1l
         Szww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698494400; x=1699099200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PiSBO3Y1WPsVw7wAvcXWqkwkpWT4KTgGbs+zAcx7ow=;
        b=W7ieuYEMC6n903+0ZoUy62Tauo3sA4MLpdQGi1mzoO+4RMv8kXKhSHB+rr/Rk9ohUE
         65CpyrwXkC1OvjnBJas4/Iq0n3+vNihgMwKg7g9SPFoScQoeEmyQY9v268NrkFqwC/rl
         r442Jt5QJn++cXx4XG6FKr0GizrdS5rJkCJ2y07Q7uZOY5tCgyIhgNviTkP0MOHq0LsE
         KoFh1fx96lAADBKBskveG9e1aSQZ9tHd6G9YYvSjRJWVYN9bdhVytq+/rFLGOrFnDKq/
         fM7zesRz5j8fRxnidWzXfM0vcsI709qEJZSJJ3U4Z5dGmVJM3HCJUWJByqkVm2t4fCCV
         jxbQ==
X-Gm-Message-State: AOJu0YxbYVMp6LIESE03sLZq/XPTh9/fOzXdGC4zNWpucQ8I/lKHuexQ
        cypr1cUZ0VWvln7vED+29d9ityCGiDmFmOKSN4E=
X-Google-Smtp-Source: AGHT+IHFhc/0+pkWR0SUGHQwml4w6qj5BunSg6KMAvcETHAASsdx3GziCfhnVPK6xL2wvUrGxAXm1wSN3GwMKqtxZxs=
X-Received: by 2002:a05:6808:a96:b0:39c:59e2:dd79 with SMTP id
 q22-20020a0568080a9600b0039c59e2dd79mr5054929oij.36.1698494400043; Sat, 28
 Oct 2023 05:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <025c3d36-587e-480c-b913-2a3916674c54@kernel.org>
 <20231028082056.43276-1-579lpy@gmail.com> <29d2e5dc-7eb1-4dba-a2fe-4829fdb65a95@kernel.org>
In-Reply-To: <29d2e5dc-7eb1-4dba-a2fe-4829fdb65a95@kernel.org>
From:   peiyu li <579lpy@gmail.com>
Date:   Sat, 28 Oct 2023 19:59:49 +0800
Message-ID: <CAELPsEZV2rgt7M_UxyhB-QZ+TWcYjgi_PORO9Tk4Lofp2AFTmw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: hwmon: lm87: convert to YAML
To:     jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On 28/10/2023 10:20, Li peiyu wrote:
> > Convert the lm87 hwmon sensor bindings to DT schema
> >
> > Signed-off-by: Li peiyu <579lpy@gmail.com>
> > ---
> > Changes for v3:
> > - add type definition of has-temp3, has-in6, has-in7
> > - Change the description of has-temp3
> > Changes for v2:
> > - replace node name lm87 with sensor
> > - replace character '\t' with spaces
> >
> >  .../devicetree/bindings/hwmon/lm87.txt        | 30 ---------
> >  .../devicetree/bindings/hwmon/lm87.yaml       | 62 +++++++++++++++++++
>
> Nothing improved.
>
> Stop ignoring feedback. You must respond to it or implement it.
>
> Best regards,
> Krzysztof
>
I'm so sorry for that.For v3 I just run make dt_binding_check and forget to
run checkpatch.pl,resulting in not finding an extra space.Now running the
dt_binding_check on my computer will cause an error regarding the
ti,ds90ub960.yaml
file when I specify the file to be checked as lm87.yaml. This error will occur
even if I specify other files, I am not sure if it will have an
impact.I'll submit
v4.If there are still issues,please tell me the reason again.Sorry again.

Thanks,
Li peiyu
