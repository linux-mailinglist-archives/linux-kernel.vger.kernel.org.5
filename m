Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D844677F5C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350551AbjHQLy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350552AbjHQLyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:54:37 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B1B123
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:54:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id BDB3C2B000AC;
        Thu, 17 Aug 2023 07:54:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 17 Aug 2023 07:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1692273272; x=1692280472; bh=NEdJCPm3giyMs38ZwoeWXBuWGg84l871vU8
        5HFz7yDw=; b=Hb18gsxbOh8QiDuyG04mw0z4nqAJJX87xwSI8Sz0J9SgFsN1nnj
        PVbM2K+3gwQ+xH9/p65YqtDqq60qYE71ivFqwiDci58/Y0zO6FkthYgPWIGPMmP5
        QgcWrFws9iUzjereb4EuGh7FWdLLmtNDkOHb3N8+lOIQ+wy01m71pwrGl+uarCjZ
        h4UeJojzhmQ6xDDgxBBKD+szpkaq8K0zr70ul4gHIo34Nkt+h5TkNS8vtPcUyqkN
        xF0CCXATNHZeYfwLc/A7Lg658646p/za2B/CSnwvu31icMglSltHSRtaDwczs4GF
        Du7nDhlmvuTvdp1nUoRF7XPu5Xw3xicKGiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692273272; x=1692280472; bh=NEdJCPm3giyMs38ZwoeWXBuWGg84l871vU8
        5HFz7yDw=; b=rGn9CjcfNjKbS1TUTUNlig6VXF7VBSJ1Uu8oXjIOH0uNFMOWP9u
        DsCYuXRlv4lv9ACoIDnv3DY9bh0x8sJvJDaOqo64F5WJavOYlFBEORapqJbJGwY7
        1mqDpPU4mPNQqDkCOeZ7784wXQNoGoM4TMiGS0r+exC6j6BW4nfIDwgT+LRaSnUY
        PRswXqZxM7lxyLmnvJ9UNLTjrOP57OJstFcm3TnZ0nmNGWxQ1U7PmMzubTH6wfvk
        dh9SJLFchTTNYNT7xgQAVn47TTIaMW8NK2F1QepjOVbWUtR89StNk1Sim/MPh4Yq
        nZvhTyRuIMaj/eOaFqOoGI8xz2r0Jg+yJ+g==
X-ME-Sender: <xms:dwreZF7SHI-f82bILVMiyNIt1qXbz-H2ez9hF6p_2sMhOjzwdAXXnA>
    <xme:dwreZC4i5I69h-NKVB_NqdLzdzMWz5Xu6TAMtAEd7QoyIfUbWFn-lKIqs_oYOAyb-
    Lb9ha69eCkVDRfiR9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:dwreZMc5oCs3KV09-SaAD1ziOu8ZMwkkSjls69u6Ewfjo5tGT_zkVw>
    <xmx:dwreZOLPeKGGazo_fX3vWLn_utuQyedB9l4XcVubGDD5071v5h-lDw>
    <xmx:dwreZJJT0SfHC5kBFVwho6YRB3mF7kV03JH25tpdbrdF6IDsLduEiQ>
    <xmx:eAreZGEuJ4zZgH5v4spzrFcosB55X_DqLm5UrISHcUkhfEexXrNce7T5vRc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B53EBB60089; Thu, 17 Aug 2023 07:54:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <4f72b1d7-00b4-4318-b3c3-50d11e4a233c@app.fastmail.com>
In-Reply-To: <15c26edc-eb4f-a90c-d52c-dd532c9d12ea@huawei.com>
References: <20230815125233.65469-1-lihuisong@huawei.com>
 <74f99c2f-fd9d-4cb9-a541-b699b79b928c@app.fastmail.com>
 <15c26edc-eb4f-a90c-d52c-dd532c9d12ea@huawei.com>
Date:   Thu, 17 Aug 2023 13:54:04 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huisong Li" <lihuisong@huawei.com>, xuwei5@hisilicon.com,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, liuyonglong@huawei.com
Subject: Re: [PATCH] soc: kunpeng_hccs: fix some sparse warnings about incorrect type
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023, at 03:37, lihuisong (C) wrote:
> =E5=9C=A8 2023/8/16 21:17, Arnd Bergmann =E5=86=99=E9=81=93:
>> On Tue, Aug 15, 2023, at 14:52, Huisong Li wrote:
>>> @@ -199,8 +200,8 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hd=
ev, u8 cmd,
>>>   			     struct hccs_desc *desc)
>>>   {
>>>   	struct hccs_mbox_client_info *cl_info =3D &hdev->cl_info;
>>> -	struct acpi_pcct_shared_memory *comm_base =3D cl_info->pcc_comm_ad=
dr;
>>> -	void *comm_space =3D (void *)(comm_base + 1);
>>> +	void __iomem *comm_space =3D (u8 *)cl_info->pcc_comm_addr +
>>> +					sizeof(struct acpi_pcct_shared_memory);
>>>   	struct hccs_fw_inner_head *fw_inner_head;
>>>   	struct acpi_pcct_shared_memory tmp =3D {0};
>>>   	u16 comm_space_size;
>> The cast still looks wrong, while both comm_space and ->pcc_comm_addr
>> are __iomem pointers, casting to a non-__iomem u8 pointer should
>> still produce that warning. I'd suggest casting to (u8 __iomem *)
>> or (void __iomem *), I assume you still need a cast here to get
>> the correct address.
> Thanks Arnd.
>
> You are right. So I modify it by dropping (u8 *) here in patch v2.
> Please take a look at this again.

Right, if pcc_comm_addr is already a u8 __iomem* or void*, that
works, I though the cast was needed since it points to a larger
object, which would throw off the calculation.

> If it is ok for you, can you apply this patch to soc/soc.git?

Yes, of course.

       Arnd
