Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7FE802E1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjLDIxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjLDIxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:53:15 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C8A5;
        Mon,  4 Dec 2023 00:53:21 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 329673200A47;
        Mon,  4 Dec 2023 03:53:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 03:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701679999; x=1701766399; bh=Br
        16u4cy0eZPz1W9bH0/WzZdoUCb+AJe3NiNEj7iIgY=; b=JW/UsSWkD948Fg19mR
        voYDi7cVd2O4lWh8Ou5OAttoXr4tMOquxA6BcBpkEZkx9abHHkoeKXvGy0SxUOjT
        3GYJ43X9b0+JEZ65+uhe/xpnaGzhr1q3vKjCQ441IY8flwvFXvdz/nxlMBTkKbRN
        Nnn29dj5mdNOdTM+P7+7an9qAMBms1D4NVY9wi5+S0tSyFT/jnTH3stup76UG5Pu
        NKoN9t3fxS6UGxypCXAI28vCSZ8+glOFMVbWm5DFcHLbbP6xG7DwDvAI5zhr8ccC
        0cjNMlXqsDLxjh/otHquIIdbI4EE85o2pVnA4Fsg4hJJhIkeg3HIDZ7kN9bpSl82
        44uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701679999; x=1701766399; bh=Br16u4cy0eZPz
        1W9bH0/WzZdoUCb+AJe3NiNEj7iIgY=; b=g68+rVPu15+TVdPRo4ftiIvKidQAT
        6Iyi4FAu/e2Mbp6yrDAajRE9qZoA3fCnNsOKR6i7810rovSuriQ/nz/DXysH97gP
        RE+jAgM86VA3Pkt/BmACKVinI+VLNCeuHrfbYW+6EQVaw+rtjj/zr6Dh5v62JU30
        iwyiurjQkxAn3A996NxWCft9cEUeb1Lwip7JXTzQZ0zpI9WDA1lTndgNvlc5vnoX
        KFgEIOc6OUFKNFqGHdxoSasWXP/f12/W1gVff8bgun63HR80H6dpZ1/IkneRrzaW
        kY92X7GSwbjJW8oiqAc35ikZgHWlJxlKIDA+ZvaYpYXENC40XbGew5YDw==
X-ME-Sender: <xms:f5NtZeclmHlcNyIFS48u56XsTrFe6tub6IymnhOOllefrE2dQlzOvQ>
    <xme:f5NtZYPJvwIU2-eQQlr5VWiKidN52tpKyDQkYnmd5cKskxSPM1OInNKL00M-8okOy
    KLYq_kIozdPk8Kt7ns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejhedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:f5NtZfjW2NC78EZis4Wu7wE3_P-WSaXyXbLGmIDmymaPDSpm6iFUSA>
    <xmx:f5NtZb_D-T4K49mZxhuFoX07sZW1CX9An0mfZK_hKPMfRFsFmsW-Qw>
    <xmx:f5NtZau2jYjzxJzMeHqNby2NDJnnCr_yjC0J0xniGukm1cIsT9TY7A>
    <xmx:f5NtZYBty1gTC-pKbdpA-h4gz0bBBOSNiGjEeNHVrBcm1Co3Gcxn2Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 70EE1B60089; Mon,  4 Dec 2023 03:53:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <dc1ba294-233a-4308-81df-23783487b817@app.fastmail.com>
In-Reply-To: <5402aa8a-a20f-4d28-bd36-3b88702ea6ae@huawei.com>
References: <20231204072932.1077878-1-arnd@kernel.org>
 <5402aa8a-a20f-4d28-bd36-3b88702ea6ae@huawei.com>
Date:   Mon, 04 Dec 2023 09:52:58 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jijie Shao" <shaojijie@huawei.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Yisen Zhuang" <yisen.zhuang@huawei.com>,
        "Salil Mehta" <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>
Cc:     "Hao Chen" <chenhao418@huawei.com>,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hns3: reduce stack usage in hclge_dbg_dump_tm_pri()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023, at 09:31, Jijie Shao wrote:
> on 2023/12/4 15:29, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>>
>> @@ -981,7 +981,7 @@ static const struct hclge_dbg_item tm_pri_items[] = {
>>   
>>   static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>>   {
>> -	char data_str[ARRAY_SIZE(tm_pri_items)][HCLGE_DBG_DATA_STR_LEN];
>> +	char *data_str;
>>   	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
>>   	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
>>   	char content[HCLGE_DBG_TM_INFO_LEN];
>> @@ -991,9 +991,13 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
>>   	ret = hclge_tm_get_pri_num(hdev, &pri_num);
>>   	if (ret)
>>   		return ret;
>
> Thanks,
>   But it would be better if there is an empty line here.

ok

>
> all exception condition also need to free memory before return. eg:


Indeed, I'll send a v2 in a bit.

     Arnd
