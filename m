Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D897C685E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjJLIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjJLIKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:10:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26A291;
        Thu, 12 Oct 2023 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=T6IKtOAUbq0dMzHmHr5ASSNdhltEbE+NwC8a+UqCoUA=;
        t=1697098219; x=1698307819; b=g51VmbPrhOjcSF+HQ+sTbfwUhYZ+8QI/YDgdEYvn7Agsb96
        hbAr7grLa74O/4RpZc66bT2YJECFmNIZjiPAqYDcmpMgc9vNS85bcVSqJHUtk87dY/G1tqxB3Qf5q
        C3mV3yuJNYypF/m5QpxiNreaGztJ38D14SEsiYDqvc0oFIpwzpwPuavkXJzsDli+rn2JziDTowi3U
        PKGGVEHzlVkLja0QVqk6Gr8Q5HzgZhMVBgy4nPvZ5PHnPzhsbEtOk+5BejDnneyxwEq+jxM6HA7VY
        nvhBV0uYGw1muk9pB4OxBM3UCQkSQzvXDkebFSqNNhhdd3me+hd9onsx2HM/xPOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qqqln-000000039S4-358R;
        Thu, 12 Oct 2023 10:10:12 +0200
Message-ID: <987ecad0840a9d15bd844184ea595aff1f3b9c0c.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the net-next tree with the wireless
 tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>
Cc:     Networking <netdev@vger.kernel.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Thu, 12 Oct 2023 10:10:10 +0200
In-Reply-To: <20231012113648.46eea5ec@canb.auug.org.au>
References: <20231012113648.46eea5ec@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2023-10-12 at 11:37 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   net/mac80211/key.c
>=20
> between commit:
>=20
>   02e0e426a2fb ("wifi: mac80211: fix error path key leak")
>=20
> from the wireless tree and commits:
>=20
>   2a8b665e6bcc ("wifi: mac80211: remove key_mtx")
>   7d6904bf26b9 ("Merge wireless into wireless-next")
>=20
> from the net-next tree.

Oops, right, I forgot about that.

> I fixed it up (I just used the latter, there may be more needed)

Just using net-next/wireless-next is fine, I actually noticed the issue
while I was merging the trees to fix the previous conflicts here.

Thanks,
johannes
