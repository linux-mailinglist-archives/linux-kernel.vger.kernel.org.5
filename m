Return-Path: <linux-kernel+bounces-138912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D040B89FBF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855D928933C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6950716F0F7;
	Wed, 10 Apr 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oHsAoTPK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ECoKpZFI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a2AYrdSz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n+1c2hTh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD016F0D3;
	Wed, 10 Apr 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764259; cv=none; b=dJda54f0LJvk/1AqNymVaMJbKhn0/aP15XlghW0w6bc8slsrwHB3Z/54l9BOoP5S1XRwJxZFvXWJIvkhqWnLpSCauuDap0bLYduozVfupzK2EIFahLAeusAs/O/b6oh/GHSwePX9yMwXH2GNOLGUjQ7jCqFBxmGw7UkFJS5nqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764259; c=relaxed/simple;
	bh=zGQjLRmM45xekVuPgxU61HGT3IKhpvxhc6cgzcmWg8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv5gb1B9O9CYnz0cFeRRUPu4KnhClAotI4BO7Yup7Z2sm1D30qLSRTC30jkyTURq4+TULdgxDivVZnmGe1TJNw1kW5Tpfzyuueg9c+/uBQMVzMzSK7//QRDe6KQRoDZE1ciL+Zh83iDAwXLxCle6+86zoAAfGlR49HMZ2DJrAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oHsAoTPK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ECoKpZFI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a2AYrdSz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n+1c2hTh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from samweis (unknown [10.149.211.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5614C1FD5F;
	Wed, 10 Apr 2024 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712764255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtETN3PS+VSk6rdHRuNMQoI0cUP1QTlqtnnmWlmHTiY=;
	b=oHsAoTPKc49GOLSh5MHgHbxSfL2JEvifAE4ja+JHBCes/WOCol74PUc9LFlfBpovICPrTa
	ruo0vhlKqtlJoDRC6maz427mRLGZ43FGYi/kY3b3m9HBLyYzKHFx7zirQZwAgP2WKBWO40
	Jpk4ovhgKWdM9cG2bTMO/Yd53QDd/Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712764255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtETN3PS+VSk6rdHRuNMQoI0cUP1QTlqtnnmWlmHTiY=;
	b=ECoKpZFIn2Bp6BR1ZCuL1JmE/DT9FeRbEwNL0t23nB43mH/Zc3Wpv+Bu7v+/+a5FaNNcuN
	E42cFv2k96r7tWCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712764254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtETN3PS+VSk6rdHRuNMQoI0cUP1QTlqtnnmWlmHTiY=;
	b=a2AYrdSzkmjxIgf1WZJEqRzc++ZK/p1UkDkls+3xmBYi6O3eU+aMoih0zKbwl1jtUie0Hf
	5BOFnWHiTyj1cRfGxzVBgMuuDsFK2JvDs2oZP6UXDfoOrM2mtdPH1LlX8wtJjjPDWuSRjh
	n+4PdbDsikW6p8x3X/zeu01nY+ilhW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712764254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtETN3PS+VSk6rdHRuNMQoI0cUP1QTlqtnnmWlmHTiY=;
	b=n+1c2hThd42yPTShdw3o0csV7hK61V4DWeIhaRzklaNJYTvoF1r+Aq3z/BiF0Kf9f2Vq9e
	7wiVAdO8VM5nz8AQ==
Date: Wed, 10 Apr 2024 17:50:52 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: 802.3ad: Avoid packet loss when switching
 aggregator
Message-ID: <20240410175052.25ac7638@samweis>
In-Reply-To: <21529.1712592371@famine>
References: <20240404114908.134034-1-tbogendoerfer@suse.de>
	<21529.1712592371@famine>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,samweis:helo,suse.de:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon, 08 Apr 2024 09:06:11 -0700
Jay Vosburgh <jay.vosburgh@canonical.com> wrote:

> Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:
>=20
> >If selection logic decides to switch to a new aggregator it disables
> >all ports of the old aggregator, but doesn't enable ports on
> >the new aggregator. These ports will eventually be enabled when
> >the next LACPDU is received, which might take some time and without an
> >active port transmitted frames are dropped. Avoid this by enabling
> >already collected ports of the new aggregator immediately.
> >
> >Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> >---
> > drivers/net/bonding/bond_3ad.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index c6807e473ab7..529e2a7c51e2 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -1876,6 +1876,13 @@ static void ad_agg_selection_logic(struct aggrega=
tor *agg,
> > 				__disable_port(port);
> > 			}
> > 		}
> >+
> >+		/* enable ports on new active aggregator */
> >+		for (port =3D best->lag_ports; port;
> >+			port =3D port->next_port_in_aggregator) {
> >+			__enable_port(port);
> >+		}
> >+ =20
>=20
> 	I think this will do the wrong thing if the port in question is
> not in a valid state to send or receive (i.e., it is not one of
> COLLECTING_DISTRIBUTING, COLLECTING, or DISTRIBUTING).
>=20
>=20
> 	As it happens, this situation, except for the case of individual
> ports, is handled just below this code:
>=20
> 	/* if the selected aggregator is of join individuals
> 	 * (partner_system is NULL), enable their ports
> 	 */
> 	active =3D __get_active_agg(origin);
>=20
> 	if (active) {
> 		if (!__agg_has_partner(active)) {
> 			for (port =3D active->lag_ports; port;
> 			     port =3D port->next_port_in_aggregator) {
> 				__enable_port(port);
> 			}
> 			*update_slave_arr =3D true;
> 		}
> 	}
>=20
> 	rcu_read_unlock();
>=20
> 	FWIW, looking at it, I'm not sure that "__agg_has_partner" is
> the proper test for invididual-ness, but I'd have to do a bit of poking
> to confirm that.  In any event, that's not what you want to change right
> now.
>=20
> 	Instead of adding another block that does more or less the same
> thing, I'd suggest updating this logic to include tests for C_D, C, or D
> states, and enabling the ports if that is the case.  Probably something
> like (I have not tested or compiled this at all):
>=20
> 	if (active) {
> 		if (!__agg_has_partner(active)) {
> 			[ ... the current !__agg_has_partner() stuff ]
> 		} else {

moving it here will run this part on every call of ad_agg_selection_logic(),
but it would be only relevant, if there is a switch to a different aggregat=
or.

> 			for (port =3D active->lag_ports; port;
> 			     port =3D port->next_port_in_aggregator) {
> 				switch (port->sm_mux_state) {
> 				case AD_MUX_DISTRIBUTING:
> 				case AD_MUX_COLLECTING_DISTRIBUTING:
> 					ad_enable_collecting_distributing(port,
> 							update_slave_arr);
> 					port->ntt =3D true;
> 					break;
> 				case AD_MUX_COLLECTING:
> 					ad_enable_collecting(port);
> 					ad_disable_distributing(port, update_slave_arr);
> 					port->ntt =3D true;
> 					break;
> 				default:
> 					break;
> 		}

I've tried this in my test environment and it doesn't fixed the issue
I'm seeing, because the port of the new aggregator is still in AD_MUX_WAITI=
NG...

The issue is that after bringing the bond up it happens that the bond link
is up, but no slave can transmit. This happens exactly when the aggregator
is changed due to timing of the received lacpdu. So if enabling the port
in AD_MUX_WAITING is wrong, what are other ways to fix this problem ?

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

