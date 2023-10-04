Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9096B7B7E73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbjJDLqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjJDLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:46:21 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1191A1;
        Wed,  4 Oct 2023 04:46:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8ECAF32009AF;
        Wed,  4 Oct 2023 07:46:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 04 Oct 2023 07:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1696419975; x=
        1696506375; bh=Q/KtTjvMil+v8KL+aP+mJR97Myi1BBiXbwWlZPHU1Nk=; b=W
        QU7IJa8O83F6rFW5rMKN2xMNCNAO1E7kUjaswcY+1o/OLZI1+fUzPCt2QpdcBQNy
        133NAH7ERLxK6zxMxRSIyhuYHevx1B5hqmgCxC8fcpHvonn1WZLjG6pg6G0VqWLV
        VxjQG8vCnyaXwDHSxn4yH0ih/7v8GErRNK3gkQ+qHwrFEibMWTZoIE6YKW/+dQiX
        ec1wbiu2/9/bjopMAJlM5gysJwhmooAwCzzRrhTP9ztCFzZvnC5FJmQR0PeJB84m
        iWme/Bil+ufrmwcyJiAzvpsoaY+MRdqxeGix8n4LhFBH6jIEi3HjBunYm+rAqBPr
        7J+R58NuSauCqFvmm4muw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696419975; x=1696506375; bh=Q/KtTjvMil+v8
        KL+aP+mJR97Myi1BBiXbwWlZPHU1Nk=; b=eFnwXzXm1yTdESHDZdKWoRIe9KrRJ
        IgPDpJaykVDGIUCjSwXnP5pdlL1NxvdPahaHo+ySa1sbe1nBQX2k9J7fT/sOks5F
        u3czjoFrLfJ9GdLxaGo5swCw3e4WBQthLLlAD+GgYpkW+ueCmXm4enGlHsyY6Zkk
        UPvmddDgMESAntvoytwnuqEDVuQeOWO4X67YhnkXh/SkQGDHKAVvBrthcKzmbjg4
        /jakHeX1HZw7duKvycYugS39KGwFxJsUM7pIi/m0RskCdp1yZjH6Mj6ksqV4KcZW
        X6XR5o2Im49KqMGZ6orpCDsjdgjduJgKkFMgGo33ZhghmGsPi5GhaK+pA==
X-ME-Sender: <xms:hVAdZUtoJ0iPK9HFbvQ9SKfr1XB7_yfGF7r9iPlilrWJBoBEGw7U2A>
    <xme:hVAdZRfmlJflt9ZWukW7n5BFWK67Z9Z35YA9XJJWa7QOv16NXgTih5mRHJR8kJBWk
    caXui3JO69XBBPNd4Y>
X-ME-Received: <xmr:hVAdZfz5sldCLkd4cNsslD93WhLhJsDOp5DvdhlHpJdoMsK_hkz9KnGw0e2gZcx_ct3nYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:hVAdZXNEAGWcGCtzozspDnqIn2K0H6T6T4HNNgbVjAb5miVRmITD3w>
    <xmx:hVAdZU875E7jEbhJIjeFLh74_j9-qkEnzKwTMbo1it_fi1AyiHnNxQ>
    <xmx:hVAdZfXWMFTrVfF75yasj8R6qpYy0AunTXqpp_mQ3q7TVrYIJoVT5Q>
    <xmx:h1AdZV0_nOCEO7VcmXqGnqVYN5ipphMc1jm1NvwYUFmZhWSqv9oVeA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 07:46:13 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C8BD710989F; Wed,  4 Oct 2023 14:46:09 +0300 (+03)
Date:   Wed, 4 Oct 2023 14:46:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Max Chou <max.chou@realtek.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Hilda Wu <hildawu@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression: devcoredump patch broke Realtek usb bluetooth adapter
Message-ID: <20231004114609.dca6ebtmx37fsx5l@box.shutemov.name>
References: <20231003182038.k57nirtt4sonvt7c@box.shutemov.name>
 <ZRyqIn0_qqEFBPdy@debian.me>
 <b2ef2f1c457a4cf7a246b2e8b8598a30@realtek.com>
 <20231004044947.vgegwvxxindkjo7g@box.shutemov.name>
 <7507ad6c8a964b179bf2b3318104a124@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7507ad6c8a964b179bf2b3318104a124@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 07:28:45AM +0000, Max Chou wrote:
> Hi! Kirill,
> I guess the root cause is as below.
> ===
> static int btrtl_register_devcoredump_support(struct hci_dev *hdev)
> {
>         int err;
> 
>         err = hci_devcd_register(hdev, btrtl_coredump, btrtl_dmp_hdr, NULL);
> 
>         return err;
> }
> ===
> If CONFIG_DEV_COREDUMP is not enabled, it would return -EOPNOTSUPP for hci_devcd_register().
> Unfortunately, btrtl_register_devcoredump_support() will return it. 
> Finally, -EOPNOSTUPP will be returned for btrtl_setup_realtek().
> 
> Could you have the following workaround for the root cause checked?
> Please share dmesg as well. Thanks,

Yes. It works and I see 

[    3.640539] Bluetooth: hci0: RTL: btrtl_register_devcoredump_support(): err = -95

in dmesg. -EOPNOTSUPP indeed.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
