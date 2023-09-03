Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8BB790F36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 01:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349716AbjICXal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 19:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjICXak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 19:30:40 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C93AED
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 16:30:37 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a86a0355dfso602527b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 16:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693783836; x=1694388636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZOoXJhaVo2TGCTIOjDSMSXw4Rlx/I9OKqXOgCPiDnA=;
        b=QjyaNp1j0skApfBFCWbN9WzbLKzOXtIRiynrVzkkMpMGgjHK8wEyLTfvxxfRGtgm8W
         CgARhwKIjnpAOBbEon/jE9Aqs49PkAt9Q25JcJMdXD1GoXMlDUclJ3/0ipnbI9E7VI1X
         JSbb6UCwnmkJMC/EAiKofARLpe1OE6kZ/wNwSnc+uPHyEDQ8T7WBuxmr5X9iQS5WcSxa
         oAmklX47nkAWVG8lGYKixFrnakrOxpuOCHYNW7c/ewbPPX6mvnJU7H8GpGX1gGst2I/u
         s+Or/mKrrzZV6dk6rumDj/2RAFb27Pui9setBGdPCg+rMGE78FwfCkKDYH3+nDCaG8m2
         4x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693783836; x=1694388636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZOoXJhaVo2TGCTIOjDSMSXw4Rlx/I9OKqXOgCPiDnA=;
        b=YcL7iHYVVgiT6b3AeOPYsDFq7bT6d+g6sac682qP7hxzUfwNAyLtzI+cXSIaoPs8yy
         qMYKf9OPxzjOoIa7rNolGJRXMBEOSBnjx5ktOnT46bKmtZfjtw3dWg/cAiwrYPtzG+Jq
         am+3+q52xfTF1o7GxURTFwd0ZktOPY3mbJr4sUdBY84YZftJrrfny5bjVMVjKZyPWtL9
         4g+MIOvZ3fzAqm+PTmc4th9mwxw5v7Kv/Jh9jU++zoHHQlOZVF/MkJL1NnwTRTnxj0Ry
         BRqfYPCR4qo2n3rvixfQ+Yy8rKn4l2rHnTx0WdDW6lDtWDLN2cB98O5V21MW8tAjFHz1
         IcsA==
X-Gm-Message-State: AOJu0YxH5nZkifdRRwMdYV0FTNaD45y6J9YOScozeu67FDMtjn2R4feB
        TrsSPN3cQk+GkuyaTVk8aiU=
X-Google-Smtp-Source: AGHT+IE52Ilxt0FJzlGKG879WYPgQGgW7wg05kjjPjvHlrTLhFnh/sEpvS/WCdZUh87TzfzToOxV4A==
X-Received: by 2002:a05:6808:148c:b0:3a9:e8bd:8510 with SMTP id e12-20020a056808148c00b003a9e8bd8510mr10293836oiw.49.1693783836539;
        Sun, 03 Sep 2023 16:30:36 -0700 (PDT)
Received: from luigi.stachecki.net (pool-96-232-116-30.nycmny.fios.verizon.net. [96.232.116.30])
        by smtp.gmail.com with ESMTPSA id b12-20020a0ccd0c000000b0064f59ca89basm3171001qvm.45.2023.09.03.16.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 16:30:36 -0700 (PDT)
Date:   Sun, 3 Sep 2023 19:30:59 -0400
From:   Tyler Stachecki <stachecki.tyler@gmail.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Atheros 11K <ath11k@lists.infradead.org>
Subject: Re: Fwd: ath11k: QCN9074: ce desc not available for wmi command
Message-ID: <ZPUXMx0H/8U9j15F@luigi.stachecki.net>
References: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
 <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info>
 <16885654-09f0-c139-cc9b-c6c4d666932e@quicinc.com>
 <ae1ad814-5613-704e-b0b1-4f1fc4bead44@leemhuis.info>
 <1945f748-fb71-f1c1-83a2-ba0470daf817@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1945f748-fb71-f1c1-83a2-ba0470daf817@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 25.07.23 11:17, Manikanta Pubbisetty wrote:
> 
> FWIW, Bagas Sanjaya just forwarded the report and the reporter is not
> CCed afaics (bugzilla privacy policy does not allow this, which
> complicates things a lot :-/ ). You have to use bugzilla to reach the
> reporter: https://bugzilla.kernel.org/show_bug.cgi?id=217536

Hi Manikanta,

I just wanted to report that this is likely related to QCN9074 when the host
system only has 1 MSI-X vector available for the modem and/or related to a
product named "WPEQ-405AX".

I have two different hosts running the exact same kernel, same QCN9074
firmware (WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1), etc. The only
differences are that the one which does not work is running on a slightly
older Intel SBC, with the older one leveraging mPCIe instead of PCIe and
only having one MSI-X vector.

I tried backing out the threaded NAPI commit and, as mentioned, everything
begins working again on the host with 1 MSI-X vector. I have also seen some
other oddities with the system only working with 1 MSI-X vector, such as
the modem not working when I boot with hpet=disabled. I am guessing it is
not related, but mentioning it just in case.

The only other thing I'll mention is that the CE desc errors are *only* seen
after upping the link (via `ip link set wlp1s0 up`). After this point, doing
something as simple as reading the temperature of the modem fails and the
kernel log starts printing the errors described above. Prior to that, however,
no error messages are seen.

I'm happy to be of service to test any changes you might suggest. Thanks
for the threaded NAPI work, by the way - it definitely provides a boost!

Regards,
Tyler
