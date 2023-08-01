Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEFE76B38B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjHALmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjHALmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:42:52 -0400
X-Greylist: delayed 186 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 04:42:51 PDT
Received: from smtpo94.poczta.onet.pl (smtpo94.poczta.onet.pl [213.180.149.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB7E92;
        Tue,  1 Aug 2023 04:42:51 -0700 (PDT)
Received: from [192.168.226.2] (1567051-1921.iaas.home-whs.pl [46.242.128.131])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dragonn@op.pl)
        by smtp.poczta.onet.pl (Onet) with ESMTPSA id 4RFY3W11lSz1yvF;
        Tue,  1 Aug 2023 13:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=op.pl; s=2011;
        t=1690889808; bh=OmZHHaG1yc2Gw63P200yn7wFAj1aCDNnGach0vZpB8w=;
        h=Date:To:Cc:References:Subject:From:In-Reply-To:From;
        b=JpRh7PkGNq7Zx2A8cxEi7Tdr3nHPa09QwNcnmqkKvgfp8AnRh5EbKrDf1oZ0qpQUc
         /sfjXXMFdF2eQ6nG/imuSlkkgHB1kA+0azpBvVCG/Na5g7HL3FAN4eTKDDNs9Nh70K
         sOVDFokBo/mGMpQKt51VxPkLtkBeeUmx5Ldlc5vg=
Message-ID: <b79630a4-0473-89eb-44da-28d87b6539ef@op.pl>
Date:   Tue, 1 Aug 2023 13:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     mario.limonciello@amd.com
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        daniil.stas@posteo.net, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, regressions@leemhuis.info,
        stable@vger.kernel.org, torvalds@linux-foundation.org
References: <61b363bc-286a-535c-27da-0f52673768ad@amd.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
From:   Mateusz Schyboll <dragonn@op.pl>
In-Reply-To: <61b363bc-286a-535c-27da-0f52673768ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was following the issue under or discord channel ROG for Linux and 
helping out some other users with it by shipping a kernel for Arch with 
disabled CONFIG_HW_RANDOM_TPM as the default recommend kernel for Arch 
for ROG laptops (as my device isn't affect by it because it is Ryzen 
4800HS).

I know it was discussed here 
https://bugzilla.kernel.org/show_bug.cgi?id=217212#c16 against allowing 
the user to disable fTPM to be used as a random source via a boot time 
parameter but I still I disagree with it.

Linux does have a parameter `random.trust_cpu` to control the random 
source from CPU, why they can not be a parameter like 
`random.trust_ftpm` (or `random.trust_tpm`)?

It might be my limited knowledge of this topic but to me it feels like 
if they is a trust_cpu then Linux should have trust_ftpm too.

Mateusz

