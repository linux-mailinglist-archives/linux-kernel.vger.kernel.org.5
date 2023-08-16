Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BA877E25D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245436AbjHPNR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbjHPNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:17:24 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440BD2128
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:17:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3B531320030E;
        Wed, 16 Aug 2023 09:17:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 16 Aug 2023 09:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692191841; x=1692278241; bh=Vj
        n94xi5RWGCup7AZFCIyVNKiwp8ToHDiiSrA8NQtEk=; b=Fn5CSScABfL/LpltM6
        RuiLwN2eNbqKTn1zVR2FGU1k+wPEdfQc7E0m10n9kl3gdxPiJbLP3aRlZXaUNoZg
        RZWmN7kL9ZrJXDOdU9fVyI4gFhS5kyB1I6LO3IIEda8qZZS8BoGNsH+HwFTcYzfg
        PNXIOFqO+YTnARXBHO4R2lk75L94KTwJTPCDOFdSTp8qHlD2cWCTBXrynxnH6t8N
        M7Yrvzp73hnI2F0dQF8eACN8sSIvEKrieLBnBgfY6DfT7FmU759h+3rsub/CDRRI
        qO8nepuo+ktX0wMBhyKqPKcufYEbcQqGwGDcdduI4AynNlIvdYBg7O0B3uDIRESF
        vAag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692191841; x=1692278241; bh=Vjn94xi5RWGCu
        p7AZFCIyVNKiwp8ToHDiiSrA8NQtEk=; b=B9PAXlckkzHQk+FjJtz34hUqaLkRl
        7ysvLKweClUgqPRbz1pW38aQcMTjVYYk2THincLg8PqkZV6MACfL7ZYJMyftW4+c
        rRexstTs31G8+icb2pVy9hu/X9p7aovs/k1ZH76Rj/sCiTW/WYYBa7H3Nsbh+G8w
        3No8Sho00yTSiVBoF9eknmceLXW9fe5TlIKixSY2aZtH8ZffebHLbaXXWcdDS5Xq
        FebXfqtEyW7BPRe/Q7JGoRQ8/rha0Bt6xTBx9vrp5GYEFYFSsTrsA+b7qoBzXndq
        75nDwo9F4Fhd8XyJUM0KpEA18SrRDu6j8np4K4SDcH14//m1j/7OJxw5Q==
X-ME-Sender: <xms:YczcZFYTGLEDkgopkLLOEIkRwXq3sxS271xAV3WmzginuwwBt8DWFQ>
    <xme:YczcZMab3bcuCd2mvH5mE6pC-mU39-EmUPuGD8-75AOyZkikpfsEFV6oMYaFiFHcG
    R4zE1kBKU4Uls3E-Cc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtledgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:YczcZH-PN6k4_r4RfW2ddMHYkctx2u3eCsLBRlagrI4G_DVpSCARWg>
    <xmx:YczcZDqfi6ffiLkeDW_W_8jI2ZI9Nc31glu8QD6vud-5HzIP5S3t-w>
    <xmx:YczcZAqsPBnSPLO7lcE-2SWoTjxnH0mTYuvo0WMU_tzhTFMW94i-2Q>
    <xmx:YczcZJkWBIxGTPuT1v_t0vvp_y6hbhyuJcTTPJtD86teLYvfglUuEg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0264EB60089; Wed, 16 Aug 2023 09:17:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <74f99c2f-fd9d-4cb9-a541-b699b79b928c@app.fastmail.com>
In-Reply-To: <20230815125233.65469-1-lihuisong@huawei.com>
References: <20230815125233.65469-1-lihuisong@huawei.com>
Date:   Wed, 16 Aug 2023 15:17:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huisong Li" <lihuisong@huawei.com>, xuwei5@hisilicon.com,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, liuyonglong@huawei.com
Subject: Re: [PATCH] soc: kunpeng_hccs: fix some sparse warnings about incorrect type
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023, at 14:52, Huisong Li wrote:
> @@ -199,8 +200,8 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
>  			     struct hccs_desc *desc)
>  {
>  	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
> -	struct acpi_pcct_shared_memory *comm_base = cl_info->pcc_comm_addr;
> -	void *comm_space = (void *)(comm_base + 1);
> +	void __iomem *comm_space = (u8 *)cl_info->pcc_comm_addr +
> +					sizeof(struct acpi_pcct_shared_memory);
>  	struct hccs_fw_inner_head *fw_inner_head;
>  	struct acpi_pcct_shared_memory tmp = {0};
>  	u16 comm_space_size;

The cast still looks wrong, while both comm_space and ->pcc_comm_addr
are __iomem pointers, casting to a non-__iomem u8 pointer should
still produce that warning. I'd suggest casting to (u8 __iomem *)
or (void __iomem *), I assume you still need a cast here to get
the correct address.

      Arnd
