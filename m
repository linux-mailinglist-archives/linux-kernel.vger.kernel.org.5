Return-Path: <linux-kernel+bounces-152428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D718ABE4B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5011F212C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814A2F24;
	Sun, 21 Apr 2024 01:28:00 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB931373;
	Sun, 21 Apr 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713662880; cv=none; b=ShonlKslQhVYkz8siDuHXWlb5pLWJRyjBmOZ56ZiDXqvbVXkWXpaJO161eOYDQXxJPAf6XJY8+6Z73XkDPNNk8O29Fcu0cySnLvVEsPot4LBLzCPqMBNCgi3x/mYzeBZrOiJYtz6ifZhfUr1ELBck0kl9xxkvcNNxSD40kh7S0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713662880; c=relaxed/simple;
	bh=vFRK9h+5k+ZVFw7k1Zs8oDgehYtBauqWEnk9WLUMUC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OgaICpwrYcHP6V7ESaIVhAF8/q+09rxbVW9j5n8MOhNhI7ejQGEkyXSfSBiBzac+GQcseRPUm9F43zyYf2DaPGsMMOVA/l/TbR/hPKZUBGqKK/IcXxNqtmTIAziTl4lONM47oykZDG4B616XDI6pMI6WJRERmLHeAcKDxim96ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 7299EA070F;
	Sun, 21 Apr 2024 01:27:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 84AD520026;
	Sun, 21 Apr 2024 01:27:45 +0000 (UTC)
Message-ID: <c24dc77d4c339d1b1ba4a76cf7c365d970cfca41.camel@perches.com>
Subject: Re: [PATCH v2] remove indentation for common path [linux-next]
From: Joe Perches <joe@perches.com>
To: sundar <prosunofficial@gmail.com>, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, neil.armstrong@linaro.org, 
	dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de, 
	christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Date: Sat, 20 Apr 2024 18:27:44 -0700
In-Reply-To: <b6f3d628-077e-486a-97f2-267324a76e9c@gmail.com>
References: <20240420164927.15290-1-prosunofficial@gmail.com>
	 <a51f703d4f8dc3b0917002c520ea6608ac642b75.camel@perches.com>
	 <b6f3d628-077e-486a-97f2-267324a76e9c@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 84AD520026
X-Stat-Signature: mioty8ocidms19zdhjpkx3hob4ci8buy
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18w+iwXIEr/hC5cNcQUEvVgTEdhIRawB/o=
X-HE-Tag: 1713662865-243079
X-HE-Meta: U2FsdGVkX19JHw36O2wr43FqbDqzmzqY8/buZSTBJF/qvlUJLz9iKI3b7sDHmmHBhvGNi0cYnf7aCGuxxH1LlDv6O4r+IaNC3TBFUOYqAyr1FDCu0syWDmg+sLmRK8My4doE2bQZQ15rDI2fd63vL0B2P9hceDDlRW0lwJcrtsrjdNxn0hIDnlQNVLARYKiaqf9JoFIpZt38AGW5QcweXFsyrYfn1y83bdgk0etgjnSM6dlohgHk9T4b4xBhq8WhbrsrzYLAy/boeAqpMreRB/chepm4V59czDhWEhnZS0trbsey6NYOKxugcaHBydgQ

On Sun, 2024-04-21 at 06:13 +0530, sundar wrote:
> On 20/04/24 22:37, Joe Perches wrote:
> > On Sat, 2024-04-20 at 22:19 +0530, sundar wrote:
> >=20
> >=20
> > > ```
> > @@ -321,35 +321,37 @@ static int nb7vpq904m_parse_data_lanes_mapping(st=
ruct nb7vpq904m *nb7)
> >  =20
> >   	ep =3D of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0)=
;
> >  =20
> > -	if (ep) {
> > -		ret =3D of_property_count_u32_elems(ep, "data-lanes");
> > -		if (ret =3D=3D -EINVAL)
> > -			/* Property isn't here, consider default mapping */
> > -			goto out_done;
> > -		if (ret < 0)
> > -			goto out_error;
> > -
> > -		if (ret !=3D DATA_LANES_COUNT) {
> > -			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
> > -			ret =3D -EINVAL;
> > -			goto out_error;
> > -		}
> > +	if (!ep)
> > +		return 0;
> > ```
> >=20
> >=20
> > Not equivalent code as the out_error:
> >=20
> > 	of_node_put(ep);
> >=20
> > isn't done
> >=20
> >=20
>=20
> Hi joe perches,
>=20
> If ep is null,  I believe we dont need to call of_node_put.  Because=20
> passing null pointer to of_node_put() make no difference.
>=20
> In of_node_put() definition, if pointer is null, there is no operation.
>=20

Fine, but you should explain that in the changelog
and not make reviewers look it up.


