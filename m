Return-Path: <linux-kernel+bounces-6743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0C6819CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F9B257EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC30208A2;
	Wed, 20 Dec 2023 10:28:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818F20317;
	Wed, 20 Dec 2023 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 089481A0382;
	Wed, 20 Dec 2023 10:28:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 280C36000F;
	Wed, 20 Dec 2023 10:28:36 +0000 (UTC)
Message-ID: <30673ad6023785016bddec34eb97f4259580340a.camel@perches.com>
Subject: Re: [net-next PATCH v2] net: phy: at803x: better align function
 varibles to open parenthesis
From: Joe Perches <joe@perches.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 20 Dec 2023 02:28:34 -0800
In-Reply-To: <20231219202124.30013-1-ansuelsmth@gmail.com>
References: <20231219202124.30013-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 280C36000F
X-Rspamd-Server: rspamout02
X-Stat-Signature: qd9csczri1n67hge4rpj5ar7y4c4fbkm
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/0wLSmeFbWCS/tyGhNbtSgcsbwtVWuqqY=
X-HE-Tag: 1703068116-712621
X-HE-Meta: U2FsdGVkX1+5/29KtORFtD1RfLYNMIPJcWKb9cPICJQj7m2D9Rf6krHQ/cC/PVjI5DsHagD5zkPAGkj7A0otWEnxV9PxjOi5isuSZZYVJOqjKYs6iVoFboSz9lFanJev3LEWk3SxHqjt0rj/y7BnrG+XxoEqSsCgQ1XTwgfpSegA8J2zMujCSTfs2P11UOaQJ0Q3ik9GKL2pVpeJ5ImPgfXKxa8ZItFRqhkkdnGBmGqpCZyFmPfAbR2mucFposmabioBBcV1UmD2w1hLoLDsGiNCJFQoSaPveTsfvjESqdkRhoP7+kR3HVvQ22Nyz8b+

On Tue, 2023-12-19 at 21:21 +0100, Christian Marangi wrote:
> Better align function variables to open parenthesis as suggested by
> checkpatch script for qca808x function to make code cleaner.
>=20
> For cable_test_get_status function some additional rework was needed to
> handle too long functions.
[]
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
[]
> @@ -2070,18 +2072,22 @@ static int qca808x_cable_test_get_status(struct p=
hy_device *phydev, bool *finish
>  	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_D,
>  				qca808x_cable_test_result_trans(pair_d));
> =20
> -	if (qca808x_cdt_fault_length_valid(pair_a))
> -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A,
> -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A));
> -	if (qca808x_cdt_fault_length_valid(pair_b))
> -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B,
> -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B));
> -	if (qca808x_cdt_fault_length_valid(pair_c))
> -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C,
> -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C));
> -	if (qca808x_cdt_fault_length_valid(pair_d))
> -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D,
> -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D));
> +	if (qca808x_cdt_fault_length_valid(pair_a)) {
> +		val =3D qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A);
> +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
> +	}
> +	if (qca808x_cdt_fault_length_valid(pair_b)) {
> +		val =3D qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B);
> +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
> +	}
> +	if (qca808x_cdt_fault_length_valid(pair_c)) {
> +		val =3D qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C);
> +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
> +	}
> +	if (qca808x_cdt_fault_length_valid(pair_d)) {
> +		val =3D qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D);
> +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
> +	}

trivia:

Using the preprocessor can make this look simpler so there's
no wall of text and no duplicated identifiers.

Something like:

#define test_length(phydev, locase, upcase)						\
	if (qca808x_cdt_fault_length(locase)) {						\
		int len =3D qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_ ## upcase);=
	\
											\
		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_ ## upcase, len);	\
	}

so these could be

	test_length(phydev, pair_a, PAIR_A);
	test_length(phydev, pair_b, PAIR_B);
	test_length(phydev, pair_d, PAIR_C);
	test_length(phydev, pair_d, PAIR_D);



