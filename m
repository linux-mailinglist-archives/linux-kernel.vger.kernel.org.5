Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E147F35A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjKUSKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjKUSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:10:03 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFFB12C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:09:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E2DB432019D8;
        Tue, 21 Nov 2023 13:09:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 21 Nov 2023 13:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1700590195; x=1700676595; bh=WOeLWiP92Y
        AALIvoUWrF5mqn2TjAV7jRPHlqWL9lWBE=; b=jayD/vE8GU3iKmkRexrSlo/FzP
        oY8/HL0iaZBlQjGsejNVPZzU+rOQ5Y3xZc9lJ4PobmsaO9bZFv4nH7m7hm+Fbe5w
        QsLu8lEI4DJyfTKLk+bg8TqbGrBZcdfKLitOOTdXmJ8fUxbXRF/0A+c4/egvuGo+
        Pb+PAE+Sa8mA5N7GBmjBcHJwymxOWTmnETDXYAV5gnfxE3s3sanpUmT914V1fIVY
        kyNXTbxSomj3ByDFad2XFprFdrHRwkNe4o1g6IHAQWcpflZq9szb2k8oeMVjx6l8
        PpjGQfq/DTrbdUHOb8xQtD1Ol7r1bkBNMGn07niM9rFjryYCPwUrNPFTPJhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700590195; x=1700676595; bh=WOeLWiP92YAAL
        IvoUWrF5mqn2TjAV7jRPHlqWL9lWBE=; b=xb7ua+JlfWG447lIHFEqs5XIgYe85
        vAs/Mk5DWzhfj+/SFFo+RJggLKzvu+Qiw9bH56LazyXIs/y7Hfzxe+mbSSXgRDmM
        Ekvh4KKOjFU2djYIlQsUuadHyvLsGVzRDtw+kyUEmsWNpXYmEQ4zUfv4jEwIHHkc
        /p4P3CvQ2QXALYof1yguHRemsXPodhKKhqCI+c3ShUxGdRl5qrmmTAsWSSwgEI5T
        4a+eQ6Iv1Q54OOWMUrHE/2fo38DlakRbeQMc3le12ezF5pUkwLqvTdsaas7wgiCl
        wNHvsawvHUaqEJJ2sg/ayLaAv1w9FrIGo/ZyB6bQhSwZWuId36mQGkICA==
X-ME-Sender: <xms:c_JcZZTKHGVJdzObeH4uUcRmwLuhq3nizl5IvLRjt3jgndWEBT8HIQ>
    <xme:c_JcZSxVqUsH8lTd0R9yRvERPCsM-hFwGn-m3KNkyb8OKBo01h4kYuiNhDoZ0O28x
    z8z74wQafB_Ru7fiuU>
X-ME-Received: <xmr:c_JcZe0jj_2yfR6TCblKTnUGQs7bFqrgrYW0DimCVBlegCfD_74Cx4EJwRp_wQ0yVEcAfPqPOknn9McocNCM8Qc9oz_GaInCLHAlE5FsmRzP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghr
    ugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhje
    egjeehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrg
    hsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:c_JcZRCmmHm9faq5ydYVjRQWlP9m539a7cMlwcTKfMhTWx5TxUW-7Q>
    <xmx:c_JcZSjZNB7RV7zvopoUMAGj55kawDnwK3dYTgAFFI2knw6ValCiLw>
    <xmx:c_JcZVoCYbmdXZUl5He_13FTwGT-omOeOM6OSwRHocLA1dh4qulUlg>
    <xmx:c_JcZTuZoUgYMVtCrUhGwqwmBDxJb1nxrFzIpiOFI168bja0OlmEGw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 13:09:54 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoudation.org, philipp.g.hortman@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 0/5] staging: rtl8192e: renaming of 5 different variables patch series
Date:   Tue, 21 Nov 2023 13:09:42 -0500
Message-ID: <20231121180947.9223-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series renames 5 different variables from
Pascal/CamelCase to snake case.

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8291e compiles.

Patch 1/5) renamed variable from HTMcsToDataRate -> ht_mcs_to_data_rate
Patch 2/5) renamed variable from TXCountToDAtaRate -> tx-count_to_data_rate
Patch 3/5) renamed variable from IsHTHalfNmodeAPs -> is_ht_half_nmode_aps
Patch 4/5) renamed variable from HTIOTPeerDetermine -> ht_iot_peer_determine
Patch 5/5) renamed variable from HTIOTActIsMgntUseCCK6M -> ht_iot_act_is_mgnt_use_cck_6m

Regards,
Gary

-- 
2.41.0

