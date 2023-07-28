Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1676764C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjG1T0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjG1T0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:26:06 -0400
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A210E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=GNXx79soC1/nqi9KpdgGwu5qSdzNR2r3BnvckSb9rmI=;
 b=NMdDROFxulMxtfI6HxhzjYNNf2MfvJs50Ol6LSWNwriJI1Qo32cBQa/SJ7T4yuiApAxSx4iNQjZF
   g1ZIb7XNiHoOrH55VzKoEOk7LJnkl7EHzbi/6R8g+hf9Fgfo6x5nYsEZjKuN8Qol4VhYSxlUrs7U
   eTk5E/MmuvD2opGFDOwwZEBVbVsxeXJEFIzEMit5WX93eLu/XuGhVo2iy+TpLQ2tfIwz3+CB4ENo
   Srm0hjuNHZdW7Thm2y02AF5T6+EFBQPdprnKSt1NUyAsfuLJgGsuS5LtZrx+VfGmiffWMhzUIk/T
   7dvhVt3b9RA/FgTCTOIuuVvp4/jnNKhSiMNAOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=GNXx79soC1/nqi9KpdgGwu5qSdzNR2r3BnvckSb9rmI=;
 b=fpbvY4OF4dmDTzIgLh+BhuCWgrRE5ZEWxI9BMFnmsI/0nWxbpGYyj+0tmaEtzZRzqjQGT94gMEoz
   U1HajJybbyIurmFbqIeFEY4MdG5DaNsDlJdd+D/VpcLJ2tfioKBahM24Sd+2bDNWW+hp5uI2wK6I
   eoLf+sqVPRJXTfo1mhvZZ5woKP+f2o8sBP8Qapzwzi/ErwvlnMAkg8GHHx9YONeaBbPSTBKMXz0+
   amMEAVLc+EvZL+p/f69Qgw9mGvGXeEwvdsN9U2fgzC9CiaeSjp3xswSxItb5QN8PDS79WlwfSH0R
   R264Ofj/PYAV5h7AzSIJRzpyJe9HY8woEmw+4Q==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYI00D2RTZD3G30@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Fri, 28 Jul 2023 19:26:01 +0000 (GMT)
Message-id: <1af52057-84e4-be2a-5fac-24847361812d@augustwikerfors.se>
Date:   Fri, 28 Jul 2023 21:25:55 +0200
MIME-version: 1.0
Subject: Re: [PATCH] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev
References: <20230728183921.17230-1-mario.limonciello@amd.com>
Content-language: en-US
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20230728183921.17230-1-mario.limonciello@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAFMx/BI9+2fEpnCAiiG34Fma+jsCm2JEnzmZKHoPTgqTmh1iK3C2jNizYSEZhxg
 ICQN8F9QebZzzi7+Kc6Sy1ZlY3aynMC72suq0out9vxx075MHLw3aUyQfpv+nYsf
 25MXeh0zjEoUQXVy5+LAIyimDu/bGjTmkuytgJmIfvFR41vaywvZr8/VWsUNISs2
 D0+0tXYL1IhLItDIRH5hcWPnIaQ/X2Odbm5fKHPnI0TLU7dLXGTtBtSy8OepCxwQ
 rRiYeamOVQKrGnkSjGrBsudKSGWdIXXGEXyzRfI1TV1iWaLos8ATH7VUzSgKbMmo
 Yw2c82aYfNZ43Wk3/T3HPUvJwGZqQj3BegRgntBnSdErrOktbVsKdSJhUPhGk25/
 8UjYD+sa70VUbJe4SFAKXX8NSInAs4RIwjkFQFzQs4mZXslOWbgjISH8Mn1BoxPy 9soe2Mg=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-28 20:39, Mario Limonciello wrote:
> Lenovo Yoga 7 needs to have keyboard interrupt signaling polarity
> is incorrect in the MADT and the value from the DSDT should be used.
> 
> Reported-by: August Wikerfors <git@augustwikerfors.se>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217718
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/resource.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 1dd8d5aebf678..1a826419d5837 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -481,6 +481,17 @@ static const struct dmi_system_id lg_laptop[] = {
>   	{ }
>   };
>   
> +static const struct dmi_system_id lenovo_laptop[] = {
> +	{
> +		.ident = "Lenovo Yoga 7 14ARB7",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
> +		},
> +	},
> +	{ }
> +};
> +
>   struct irq_override_cmp {
>   	const struct dmi_system_id *system;
>   	unsigned char irq;
> @@ -494,6 +505,7 @@ static const struct irq_override_cmp override_table[] = {
>   	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> +	{ lenovo_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 1, false}
This should have ACPI_EDGE_SENSITIVE, not ACPI_LEVEL_SENSITIVE, see 
https://bugzilla.kernel.org/show_bug.cgi?id=217718#c11
