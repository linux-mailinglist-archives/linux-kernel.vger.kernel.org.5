Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC61379C2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbjILCTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbjILCT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:19:26 -0400
Received: from out-219.mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA47B7A7F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:42:33 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694482951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jz1TTZmea1CLeqBzO6DM6M9LynoT0Lt4nmv857GbDQ8=;
        b=uzJZdzA/ZWyQb1Gp7SiKWp8rK22R2R9BoxXok0Gaw9niIX29KIT3CR2J/cud0NnSQllnhL
        o8c9zlxjCS01tAh8u36eZg0yLfhsy5c9sEOmdakfMNKotjlz7DzxkojuS1vBlpTknFgKTz
        Ng1CzIcKt8bJgE9JShoEukb1YxIKPQw=
Date:   Tue, 12 Sep 2023 01:42:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <5aa174ef5cd662595ffcefd3545ff07ed3063d6c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
To:     "Stephen Hemminger" <stephen@networkplumber.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230911091513.4f2f2aed@fedora>
References: <20230911091513.4f2f2aed@fedora>
 <20230911082016.3694700-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

September 12, 2023 at 12:15 AM, "Stephen Hemminger" <stephen@networkplumb=
er.org> wrote:


>=20
>=20On Mon, 11 Sep 2023 16:20:16 +0800
> Yajun Deng <yajun.deng@linux.dev> wrote:
>=20
>=20>=20
>=20> Although there is a kfree_skb_reason() helper function that can be
> >  used to find the reason for dropped packets, but most callers didn't
> >  increase one of rx_dropped, tx_dropped, rx_nohandler and
> >  rx_otherhost_dropped.
> >=20=20
>=20>  For the users, people are more concerned about why the dropped in
> >  ifconfig is increasing. So we can export
> >  dev_core_stats_rx_dropped_inc sets, which users would trace them kno=
w
> >  why rx_dropped is increasing.
> >=20
>=20
> ifconfig has been frozen for over 10 years, and is deprecated so there
> is no point in catering to legacy api's. There are better API's such as
> ethtool and netlink that can provide more info.
>
Yes, ifconfig is deprecated. but the dropped in ifconfig and ip is the sa=
me.
We're more concerned about the reason for dropped packets.
ip, ethtool and netlink couldn't show the reason.
