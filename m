Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6254A7D781A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjJYWj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYWjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:39:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA839196;
        Wed, 25 Oct 2023 15:39:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0ADAC5C02E8;
        Wed, 25 Oct 2023 18:39:22 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 25 Oct 2023 18:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1698273562; x=1698359962; bh=b5
        5NcfQ5xCyEdZOc8Aq3u1s3aUOq5RcPmQVdE0Ch+qM=; b=mjB2N/UgNTWhvP1dRe
        mbkRdn3La3nncjTWyagGWzkaZpp40o8YuWjSh9RWfqAdKdPGoG1dYj0hsTCLFrN2
        lVsjkpD19MUULLFT7aduzuulBILuYz86jYXdJHYamhziEO2Oes3Jw4wSERrXfEXT
        +9RZ9e7cRfZCHXqiiohlBL/L3FqI6Zm+9skmP1OHXO8kA4HQSSld55a99dHj6nLE
        Z835J+wQxIu/SKbNCIE3d6pPD8j3YVDwhVbDa2C+dNHzRjmiR29FQVzrjkwCwWOk
        dWuBLUvtRtulgDgeTcJFx+CJ+jnWT23y47iqTPXcNNI0yGWA65A7OZkPqrY0AA6L
        bO7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698273562; x=1698359962; bh=b55NcfQ5xCyEd
        ZOc8Aq3u1s3aUOq5RcPmQVdE0Ch+qM=; b=O83bfJdsOqanvX54GAteOPXD064Ed
        3SEPvS+FETDtqa2Mg1puEgx6AJntWhThMGMZyBjvotnfzQbgS752Q/pNmtsjtALB
        nmU5zaqm5BIKibhFdUOkctreC5lKF8JZnFGs+Cvg5cY3mWg0/t9EEFXqChhK/XVz
        KEfe6xr/yV64DG4MHF4mmShCGJwDgUMZ860j5civ/zM0/EJFOuR1IJq6AmcabhgZ
        Neflf7DeceZQxdOYIVOEtWuDNPCIBJSiZKIPflIS0SP1FOad+TSreTIRci/3GPxV
        kX9ZHkaV9PT02VQEqNM7B2L+gtGWQ/u0pd7GndwqPE4ezyUlTxCgBzWDA==
X-ME-Sender: <xms:GZk5Ze-qvx4vwlmVFU_9Z9zWCR-zLT4K2QWd79MHJIz_y6IUJgQ0oA>
    <xme:GZk5ZeudeGkCKzoDelj_by0-LHUEpkaXzNXPFbgDDc6ExO0Bi1jHjTIdUFfE0tKOU
    YZHVb_9WIVCr4QfKn8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpedvveejudffvedtleduveevgeelvdejffetheehjeff
    hedvueekhedvueduleetfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhfrhgvvg
    guvghskhhtohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:GZk5ZUC3QJzGjcXORpyg7acAmFI4wd5gFotn_1YxcpgEqLonG9KGtg>
    <xmx:GZk5ZWfyFGDuqRW6suddAYl5FcmdKD1RnMw_y71UKKZJByHfHqKvFA>
    <xmx:GZk5ZTOE678Li2KkLV2Eiu-oCp8-FLADvdQ0Mk9tI0epwI5iVL_3FA>
    <xmx:Gpk5ZYqCSWuyq7Q93madyKQaVetwdc3iAubNY4oSzJKwoTxW297T8g>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B74EBC6008B; Wed, 25 Oct 2023 18:39:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <9268ad86-230f-4e98-8592-e87b3d0e08b7@app.fastmail.com>
In-Reply-To: <4f6181c8-07f1-471e-a186-6a129a2f0b2b@amd.com>
References: <ZTlsyOaFucF2pWrL@localhost>
 <4f6181c8-07f1-471e-a186-6a129a2f0b2b@amd.com>
Date:   Wed, 25 Oct 2023 18:38:57 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "David Lazar" <dlazar@gmail.com>,
        "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Add s2idle quirk for more Lenovo laptops
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David for doing this.

On Wed, Oct 25, 2023, at 6:06 PM, Mario Limonciello wrote:
> On 10/25/2023 14:30, David Lazar wrote:
>> When suspending to idle and resuming on some Lenovo laptops using the
>> Mendocino APU, multiple NVME IOMMU page faults occur, showing up in
>> dmesg as repeated errors:
>> 
>> nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000b
>> address=0xb6674000 flags=0x0000]
>> 
>> The system is unstable afterwards.
>> 
>> Applying the s2idle quirk introduced by commit 455cd867b85b5
>> ("platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of
>> laptops") allows these systems to work with the IOMMU enabled and s2idle
>> resume to work.
>> 
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218024
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: David Lazar <dlazar@gmail.com>
>> ---
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
>>   drivers/platform/x86/amd/pmc/pmc-quirks.c | 73 +++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>> 
>> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>> index ad702463a65d..6bbffb081053 100644
>> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
>> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>> @@ -111,6 +111,79 @@ static const struct dmi_system_id fwbug_list[] = {
>>   			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
>>   		}
>>   	},
>> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
>> +	{
>> +		.ident = "V14 G4 AMN",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "82YT"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "V14 G4 AMN",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "83GE"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "V15 G4 AMN",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "82YU"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "V15 G4 AMN",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "83CQ"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "IdeaPad 1 14AMN7",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "82VF"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "IdeaPad 1 15AMN7",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "82VG"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "IdeaPad 1 15AMN7",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "82X5"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "IdeaPad Slim 3 14AMN8",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "82XN"),
>> +		}
>> +	},
>> +	{
>> +		.ident = "IdeaPad Slim 3 15AMN8",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
>> +		}
>> +	},
>>   	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
>>   	{
>>   		.ident = "HP Laptop 15s-eq2xxx",
