Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBED797812
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjIGQlV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbjIGQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:41:01 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A30A10CF;
        Thu,  7 Sep 2023 09:40:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7e6d9665bcso1026784276.1;
        Thu, 07 Sep 2023 09:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104450; x=1694709250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok2CriQTwYEsC/n/gnqFCKaHzQ1Eyzk+MG3g9UT+Zeo=;
        b=ksTlNc/0kx7NBz0A/4U6s9BBl7CTT4Ouul33W4ducuPCzsEBtAPqtkx71axozn9wl8
         oXkmv1Bv0KYBrqhewHlHfpvJ9fyzTz1CcayVdJLU2oTvOO61rzTprYlhEFBjOhm/v+xS
         CZ9AUp108nOOyWw/Zn66hiaEi5zH+F5SQIsPSWbm1VysogAMUkVEdQdMWJeVnBLjB3yR
         1oasg8ovuXD/9EBOezg+UccdKmSpieUZMsbEGfj+/tOctJhFjgy61LD3BIIcOuiAX0BX
         PcNmwT1zI27hhDvN9veCiJR3VQBXJDAxryY257gNrNC5EmwMIdqWat7cGNlSVsfpejgx
         xv+A==
X-Gm-Message-State: AOJu0YwU/1WJlpqa9ziLQRYX7ZSMfObRHUa3xmtSh/Fq6/7+O8zjaVX+
        +BcycOXK0p0y4BuWNUcwvWY2KR4teaocHrsqJCI=
X-Google-Smtp-Source: AGHT+IFORxOKHFqeh0WuVDZ5nkcMQqs+D80xPEyaTNXZH9YVDY5S2r6XCDnHRzxMvQHfnVxnd4F/z76XRWY+TerP/Kg=
X-Received: by 2002:a05:6902:120e:b0:d77:e463:7c0e with SMTP id
 s14-20020a056902120e00b00d77e4637c0emr24999040ybu.50.1694104450584; Thu, 07
 Sep 2023 09:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230620170027.1861012-1-weilin.wang@intel.com>
 <CAM9d7cichi8QpVFjCDUf8e5aJEuZg1JPHtMBEs_FSNtsm8VoeA@mail.gmail.com>
 <CAM9d7chBM_z=vNKsLFTLVevXgd8=ZfS_XSX=999+jitrTJodTA@mail.gmail.com>
 <CAM9d7cjd022T5n6TyD96M_T5KNjHTDgjfK_mKKTZYMmKEKi58w@mail.gmail.com> <CO6PR11MB56356C7AA628AB72DC33D3ADEEEEA@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB56356C7AA628AB72DC33D3ADEEEEA@CO6PR11MB5635.namprd11.prod.outlook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 7 Sep 2023 09:33:58 -0700
Message-ID: <CAM9d7cij=Ph_esnEwDVSRYZRi9i_GOgRfa7rK_DjihX1rnk_HA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add metric value validation test
To:     "Wang, Weilin" <weilin.wang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 9:58 PM Wang, Weilin <weilin.wang@intel.com> wrote:
>
> Hi Namhyung,
>
> The report shows there are four metrics return with no values. Do you know which processor this was tested on?

It's a laptop with 11th gen CPUs (tigerlake).

$ head /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 140
model name    : 11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GHz
stepping    : 1
microcode    : 0xac
cpu MHz        : 3899.531
cache size    : 12288 KB
physical id    : 0

>
> I can look into the test and see if I could improve the final report to make it easier to debug when fails.

Thanks,
Namhyung
