Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCCA7E8531
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjKJVkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKJVkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:40:01 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F5BA9;
        Fri, 10 Nov 2023 13:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zv4p0IORXbUduRi4hB1ViF0SxIffSRz9cFMe9JTmeIQ=;
        t=1699652398; x=1700861998; b=S4RLP2TGncVD+SsWLHv6/8l3YTBVtDi0qZK8MKnEE6dG45g
        5GP0lEuMgoTgKz/mgEH/o41FCZ+DWSzu+NKXD3XrKsoOwX65zY8UEe9n8AIOsacpBn7MPR7I3P2/n
        90dYK+MbxGlJdocf+QSv0Gd5eDhkWSL89j0Dvwh/V/uvvcqLDoG0a6iZky/Jx4kIwM2ul6QlMEWHu
        oNnqZx3b+N4W4F2khVYrTVEV3G0s/WV52DQ/2umYPQ+V6+OSr2wVJ+RAJxYjdx6VgS8W5U/UAdFuT
        KO14sf/uwdxdw72CeZQnGy2ukNmd/wDVjxyQKFXcO8fzLEeDF4Gr5EIeVMoxMPlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r1ZEJ-00000003DcW-2daU;
        Fri, 10 Nov 2023 22:39:55 +0100
Message-ID: <c4c14b15d5e0c2e4650b50ef7ae9d8755f83900e.camel@sipsolutions.net>
Subject: Re: [PATCH] mwifiex: clean up some inconsistent indenting
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        briannorris@chromium.org
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Fri, 10 Nov 2023 22:39:54 +0100
In-Reply-To: <20231110083327.7022-1-jiapeng.chong@linux.alibaba.com>
References: <20231110083327.7022-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-10 at 16:33 +0800, Jiapeng Chong wrote:
> No functional modification involved.
>=20
> drivers/net/wireless/marvell/mwifiex/sta_event.c:789 mwifiex_process_sta_=
event() warn: inconsistent indenting.

OK, sure ...

> +++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> @@ -762,7 +762,7 @@ int mwifiex_process_sta_event(struct mwifiex_private =
*priv)
>  		mwifiex_dbg(adapter, EVENT, "info: EVENT: AWAKE\n");
>  		if (!adapter->pps_uapsd_mode &&
>  		    (priv->port_open ||
> -		     (priv->bss_mode =3D=3D NL80211_IFTYPE_ADHOC)) &&
> +		    (priv->bss_mode =3D=3D NL80211_IFTYPE_ADHOC)) &&
>  		    priv->media_connected && adapter->sleep_period.period) {
>  			adapter->pps_uapsd_mode =3D true;
>  			mwifiex_dbg(adapter, EVENT,
> @@ -773,7 +773,7 @@ int mwifiex_process_sta_event(struct mwifiex_private =
*priv)
>  			if (mwifiex_check_last_packet_indication(priv)) {
>  				if (adapter->data_sent ||
>  				    (adapter->if_ops.is_port_ready &&
> -				     !adapter->if_ops.is_port_ready(priv))) {
> +				    !adapter->if_ops.is_port_ready(priv))) {
>  					adapter->ps_state =3D PS_STATE_AWAKE;
>  					adapter->pm_wakeup_card_req =3D false;
>  					adapter->pm_wakeup_fw_try =3D false;


Seems fine.

> @@ -781,12 +781,10 @@ int mwifiex_process_sta_event(struct mwifiex_privat=
e *priv)
>  					break;
>  				}
>  				if (!mwifiex_send_null_packet
> -					(priv,
> -					 MWIFIEX_TxPD_POWER_MGMT_NULL_PACKET |
> -					 MWIFIEX_TxPD_POWER_MGMT_LAST_PACKET))
> -						adapter->ps_state =3D
> -							PS_STATE_SLEEP;
> -					return 0;
> +				    (priv, MWIFIEX_TxPD_POWER_MGMT_NULL_PACKET |
> +				     MWIFIEX_TxPD_POWER_MGMT_LAST_PACKET))
> +					adapter->ps_state =3D PS_STATE_SLEEP;
> +				return 0;
>=20

=F0=9F=A4=B7=E2=80=8D=E2=99=80=EF=B8=8F=EF=B8=8F
That's not really an improvement is it? You've just indented the
function arguments as if they were part another part of the condition? I
mean, sure, it was awful - but ... maybe better break the 80 cols rule
(which isn't one any more anyway)?

johannes
