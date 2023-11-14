Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83437EA979
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjKNEZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKNEZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:25:48 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916721A1;
        Mon, 13 Nov 2023 20:25:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DF955C0269;
        Mon, 13 Nov 2023 23:25:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 Nov 2023 23:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1699935943; x=1700022343; bh=ZusIk4MCoiAToI/Lp26CblAj2l/PcBH1u8J
        2IHpPS94=; b=RgB+Fs6HK1Z5cs0YvE2hbsJaN77Jz08rkJyD7Bqt0+WVHPhT1ir
        cb/NB7QDleftj8O5FZvnclKBgWj0+mkEkUVhydvWZICxnK9Ld7KuDx4fChNdBK9P
        G4rjpvo8o9X1z+LD+Kkr+1GPrFc1YRRHlDskSf5YKN8Zs/J9As1llpRyhKq1E91O
        ElxXi7x1737of8/vAoA1tFbM2DRcUIc1z4ZPelM223mIj+8Jk1/GJvnVxSn6yd6W
        rlnzruQjz8aoy5tMQ24dh/C7RQquQqSfTKi884OKdrbkEiUrwPZnosM7XIakYN6c
        tR0Gk/4WBwD8Qxcjzrd+FNEpEnhewzy2stg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699935943; x=1700022343; bh=ZusIk4MCoiAToI/Lp26CblAj2l/PcBH1u8J
        2IHpPS94=; b=rHI0nZ09hFURiRKRtjk7HaCH+mHm37O4gS/x316ZtJmdLcUZHJO
        eTBlMA1SpPc+WUGqYAbMrl0cTOcDX9bxQaiZI7kHoLjZcVOHSYkkDwHF8TvvsZQl
        jX/S2Tl6L8S5FRgZzEWVUNf2R2sgvjSqUKIotdYYDxmzBGhRi9QPN4HKRzMDF7Hg
        hAcHfgd0tBCPWlKSi2DLG92Fp+eHUsstYqCSsBBYUr9JXrjhw7+6SIMFLiWnZfuN
        F4vpVEJ4lmrvK9jhgzYPwvoJRm+kEAOjMrImv0TGst3JefFGO7xnPkcDu1L3y3xt
        iayBuDYyKZQqnxbCLLNaSdqydhcuu59tZYw==
X-ME-Sender: <xms:xvZSZYNS5J82QR6gcEbQL3_bGXfwEE1pCYEsxTNhmdAWzcCa0moi-w>
    <xme:xvZSZe_vEikqkvFSm2PWa-EOlwo_bfpFnXKi0SPCyWzkDuDqIoRzLefiORx71Xabe
    3lYNsmCeNrc>
X-ME-Received: <xmr:xvZSZfQ6VepDuMxuL0TXpiX0RgAbByPMjGHFsH4vgaqv4BTRTAjkTYFRTiexgpl28KWFS21q3V-qFNLTneQ78eOCJtI9RfQSrMyoYIdqQtS9tQ3VEwuJ7ca96g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtredunecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    ephfeguedvieettdellefggfejveegffdugeffveegjeejtdettdekvddufeffjefgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:xvZSZQu-FI_YkCXLgahuIXnBvipZx8JqbLd2Nt3Ndz1JxAdD11Z28g>
    <xmx:xvZSZQeR-oYtgIN7M0TCB5FAP5qwyW_yA_V2JWTGiFENAkG2aOvyWA>
    <xmx:xvZSZU2mVty5sOBnu6-2pM4OlmlzSfYRC-ABlMLKidwNe3MI4E3Qbg>
    <xmx:x_ZSZY6oPvoElFAFlKTTBxZH11EaizMOStVAAwAJk5gy5fJRRalC6g>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 23:25:38 -0500 (EST)
Message-ID: <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
Subject: Re: [PATCH] autofs: fix null deref in autofs_fill_super
From:   Ian Kent <raven@themaw.net>
To:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date:   Tue, 14 Nov 2023 12:25:35 +0800
In-Reply-To: <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
References: <000000000000ae5995060a125650@google.com>
         <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-14 at 11:52 +0800, Edward Adam Davis wrote:
> [Syz logs]
> KASAN: null-ptr-deref in range [0x0000000000000000-
> 0x0000000000000007]
> CPU: 0 PID: 5098 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-
> 15601-g4bbdb725a36b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 10/09/2023
> RIP: 0010:autofs_fill_super+0x47d/0xb50 fs/autofs/inode.c:334
>=20
> [pid=A0 5095] mount(NULL, "./file1", "autofs", 0,
> "fd=3D0x0000000000000000") =3D -1 ENOMEM (Cannot allocate memory)
>=20
> [Analysis]
> autofs_get_inode() will return null, when memory cannot be allocated.
>=20
> [Fix]
> Confirm that root_inde is not null before using it.
>=20
> Reported-and-tested-by:
> syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> =A0fs/autofs/inode.c | 3 +++
> =A01 file changed, 3 insertions(+)
>=20
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index a5083d447a62..f2e89a444edf 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -331,6 +331,9 @@ static int autofs_fill_super(struct super_block
> *s, struct fs_context *fc)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0root_inode =3D autofs_get_inode(s, S_IFDIR | 0755=
);
> +=A0=A0=A0=A0=A0=A0=A0if (!root_inode)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail;

Yes, I think this is the only thing it could be.

There's one small problem though, it leaks the dentry info. ino,
allocated just above. I think this should goto label fail_ino instead.

Note that once the root dentry is allocated then the ino struct will
be freed when the dentry is freed so ino doesn't need to be freed.

Ian
