Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF37BB06B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjJFDCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFDCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:02:08 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9621CD6;
        Thu,  5 Oct 2023 20:02:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79fa5d9f3a2so70496439f.3;
        Thu, 05 Oct 2023 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696561325; x=1697166125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7jsDyJHAOcOCgxSJEzqajp1/MqcnDBxKNllh4yji8k=;
        b=OTkYHtqp/vvzDiMmbcAw0R2kUWzNbabCSf5oy3s9WObcy3KxMWBVYoV4Ej7nLqrBlY
         gB8tnI6aVg9aEAFr6LjxE462ekCASoNU/nHx75LoKBB9/O2lVI9Fj5BAgZSX/IcvFC/K
         oKcOLW/WEH5Gk9NzgWIcV8MXwwq6R81WLUnzZmi+EU5B8gQNjdBlqTrlIOS0bPj9Q96V
         4KVaqcQy6m1mN/sQW5bIiAUqVaniCsNf/HQws2SqVZrdHSFm13a6RvDX35y6kuk4MyE+
         6PQyrcMXRCqIpBRkigUnO/sYKNdaeHti7JRP1SjlBt7r+e9P7qwILTsH5+PqsoCbrOdm
         99Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696561325; x=1697166125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7jsDyJHAOcOCgxSJEzqajp1/MqcnDBxKNllh4yji8k=;
        b=AqQ6ZchWXoEuXyvCB8lat67ruGb4z24OIO+Wea2zXhWkHz8V0wqNeTXlGls+sPvEdN
         fNB+jzcKAPKy810mN7BoscRubD0LQnMx3+WSqJr9Ey9tvSWxY+BZ1wKrZVWsIdgeVRw+
         mVzSVw5jYmekUlqa6C3rA1SHwfRFcthlL1hog8ABC393eME2ihdCLjn+o3Kg1+oajgcx
         PS30O+/HIg/IZmp8+3UVWF8pedNCRKFQl//mvpqHHtGrSb+JClZtXsLuVBzrTh75Q7YN
         K0+DA7LrrxfWzqNV1yaueMWykksl9uR4Ti6U7e5RjLLxZPK0o0mdBS+Xk2Z++H83jnvH
         9MkA==
X-Gm-Message-State: AOJu0Yx4BDRuIF3txq0+asOIM7W5RM8iqG/1/5fR4kDxUGByYariYNH7
        8eoZac3JR/FaRPuS+0rTexI=
X-Google-Smtp-Source: AGHT+IFxz7b0lJ1fngfStUeoueHr5eIHWhk83Qc8PCIveFkamkwk3MWploBUuoczYgLk68vp6A6ljQ==
X-Received: by 2002:a6b:919:0:b0:792:8230:c175 with SMTP id t25-20020a6b0919000000b007928230c175mr6956244ioi.6.1696561324859;
        Thu, 05 Oct 2023 20:02:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o16-20020a02cc30000000b0042bb296863asm164464jap.56.2023.10.05.20.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 20:02:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 Oct 2023 20:02:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/5] watchdog: eiois200_wdt: Add EIO-IS200 Watchdog Driver
Message-ID: <d7df3c7b-730a-4d09-8f15-3cc8591c8092@roeck-us.net>
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696495372.git.advantech.susiteam@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:51:18PM +0800, advantech.susiteam@gmail.com wrote:
> From: Wenkai <advantech.susiteam@gmail.com>
> 
> This patch series aims to add support for the Advantech EIO-IS200
> Embedded Controller's watchdog timer to the Linux kernel. The EIO-IS200
> is a widely used embedded controller, and this series introduces a
> native driver for its watchdog timer functionality within the Linux
> ecosystem.
> 
I am not going to review this patch series. This is just one watchdog driver.
One patch is sufficient.

Guenter
