Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCD4784015
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjHVLvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjHVLvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:51:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA5CD1;
        Tue, 22 Aug 2023 04:51:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bba48b0bd2so27912115ad.3;
        Tue, 22 Aug 2023 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692705088; x=1693309888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR2xuLZfSkQwU3fKeNoiqzMS9NnHXyWCvWXVgRfiJxk=;
        b=gX0e9f8eyApzuUOec0VlM2bKlg31sXYKwP/LdvdrejRsMYqW1/kd6JnE/8csnm8C+Q
         TA8daDK/S/dGZpp00bFveZPul5lkptKaJbK4qxaOmfQxddS03+HtX8RWhpx9cem/+WEq
         9vz66XbG2kgOMaGxzGRo9G0FeTRSUI34dcd0nLExJptlquujPP11HrFm562OMKvqI/lU
         k8pVzK+mVEMrKJ2lngny1x4t1GtIiDsyINSNF7IpQrFSqzXdiorplxggcuRz8C1B3v0x
         6gtXB7qMV4sJWqYJYvr5BRjiC6E5i9eGYXTnDsCQEWNmII+K2+Px2//9dhCy9lpPjdhQ
         Gi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692705088; x=1693309888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR2xuLZfSkQwU3fKeNoiqzMS9NnHXyWCvWXVgRfiJxk=;
        b=E9RykIn6bMVFpuegoN4HP51GrJoDUZ24zeBvdqjBVLaGq10P429mW4KoTdbWVdYahm
         czj8ZWnAYuHpUOfW1UeuEq9xKd5jBlpq2kyTP6WsoU2y28w10jsn6NuokGO6WoQgjHon
         eytxthwcw79Ji2AwrhnoPfoTY7lpHy154SVdClqFnlqva5ee9/sAHyNSOKDpp2ht/Rrz
         8nFWojXdpO+9b+xuL8IxhXdHnDo3pXNX6VrphyPgUWRnKfeNR1aSJMzdiXCpfNsbNn+q
         U6/CNjMOeBGcmuTKU/0fCMJvWmT40eyAWa4tzG3+i5gMp8ni3KxjRnO/AN2BGxVAFyco
         R2Cg==
X-Gm-Message-State: AOJu0YzPely84/F8A2BHTOFOPH/TF0yD/MCwBUgpDPqrpN5IfMzNTpgD
        BSSpeAp61X/i2+RvHEQ4x2U=
X-Google-Smtp-Source: AGHT+IFou1M3WdOt6QED19FVN7h633yC1gfrkYv2Z0aullsB01KfCUrX7NzPPWXluJahGeiT+0GyXA==
X-Received: by 2002:a17:903:228a:b0:1bb:2ccc:c321 with SMTP id b10-20020a170903228a00b001bb2cccc321mr8116500plh.48.1692705088074;
        Tue, 22 Aug 2023 04:51:28 -0700 (PDT)
Received: from raven-lpc.lan (li1452-23.members.linode.com. [139.162.39.23])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001b9f7bc3e77sm5082611plb.189.2023.08.22.04.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 04:51:27 -0700 (PDT)
From:   Raymond Jay Golo <rjgolo@gmail.com>
To:     ronan@rjp.ie
Cc:     jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, ps@pks.im,
        rjgolo@gmail.com, stable@vger.kernel.org, todd.e.brandt@intel.com
Subject: Re: [PATCH v2] tpm: Don't make vendor check required for probe
Date:   Tue, 22 Aug 2023 19:50:49 +0800
Message-ID: <20230822115049.6276-1-rjgolo@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <5c5de3dee5e5fcc4fbdf80226f0697f6269c585f@rjp.ie>
References: <5c5de3dee5e5fcc4fbdf80226f0697f6269c585f@rjp.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
> reported systems the TPM doesn't reply at bootup and returns back the
> command code. This makes the TPM fail probe.
> 
> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, check
> the chip vendor and if it's not AMD don't run the checks.
> 
> Cc: stable@vger.kernel.org
> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Reported-by: Patrick Steinhardt <ps@pks.im>
> Reported-by: Ronan Pigott <ronan@rjp.ie>
> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Check x86 vendor for AMD
> ---
>  drivers/char/tpm/tpm_crb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 9eb1a18590123..7faf670201ccc 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -465,8 +465,12 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
>  
>  static int crb_check_flags(struct tpm_chip *chip)
>  {
> +	int ret = 0;
> +#ifdef CONFIG_X86
>  	u32 val;
> -	int ret;
> +
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +		return ret;
>  
>  	ret = crb_request_locality(chip, 0);
>  	if (ret)
> @@ -481,6 +485,7 @@ static int crb_check_flags(struct tpm_chip *chip)
>  
>  release:
>  	crb_relinquish_locality(chip, 0);
> +#endif
>  
>  	return ret;
>  }
> -- 
> 2.34.1

Fixes problem on my machine.

Tested-by: Raymond Jay Golo <rjgolo@gmail.com>
