Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0777CA8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjJPNEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPNEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:04:45 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01634AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:04:41 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 357FA5C03D7;
        Mon, 16 Oct 2023 09:04:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 16 Oct 2023 09:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1697461481; x=1697547881; bh=xfCk1H6yPjURpgzTVBLKLCz6DqhCoRy4iVi
        CI/lUIfw=; b=fMeU5viM7GNom2rU1dkI2xK8OKzMUum2zP5S6swXhy2zVzskQj4
        qlx+vyEm6WIfh2W1YIxikEMXFfDC0/d+aG4iz+JG66uVnjf7m1etuCAgmWZazMqj
        SgVzP4AbhEK0XhEbDD1G9kkX+VHF7069sRTNtUvlVANmGBBUwjTLw/QWDqYZ+vuG
        MrgedNq1qedTF42M55xZMP1LbqrdAWdIVkDLySjIViwTggRDsy9YWVKbTO1Mjep4
        r6qaXMUeLZRVGwiT6aEufeTgOPvAEoCi3HHFc4KDThWdwXrIME5tG0y5kPW/LXL3
        rvT43DuEZEbEJa8pwTNSWcwmMMHnNYV5fdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697461481; x=1697547881; bh=xfCk1H6yPjURp
        gzTVBLKLCz6DqhCoRy4iViCI/lUIfw=; b=TKx8fyjQX/u6KGpZbVEXtlq5EKTD1
        TaV/80k+9pYpBaHW6VfKp6Bu2lg4IV/882MZDyOauUZNeSOnkaVgxAGqSbA5d/7w
        1juUPNX7x18Ze1hZU3CrLi88xgeQTPDlJXy0lYfjk10qIKvCCACw8gtbiR73D7ty
        729CZFGpNd1DyfBRPb3w6mkBo3IooyLg/rpqMOiVUprl9gLupj3ip2mag4cwR+fd
        /3GYyD6mU6PF6rWS4J8+3dVypcECkhr1bgZTzVJBgzxqKKELMhZyE60zsJfziXmp
        QB6glF0/jIyfBWNowfOMPwDyPGbOrQ3gRi1sH5KWA7pv+ML+Z2n4yv4BQ==
X-ME-Sender: <xms:6DQtZfT6uSllhXuw_POxUITdwQZKHe12cZ6wrgmDixuWfoAecUFvjA>
    <xme:6DQtZQwujRTyLGs9wyzqVKZovuhLuVQPwC7ule7XQ92HNAZMWvKIODhdyDwJmh-Dt
    dNqdPZ7jJrXng>
X-ME-Received: <xmr:6DQtZU2762mOR7LAGtlbPoWjlfak7_EeLWg5ZtfgWb9TyA9hlyJ4AW7w1xk-_NJbFjClPiIzkJ0-adoPNCCwMCr16PVxdkM3yoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedtgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudel
    teefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:6DQtZfBZhZn_lhBNgCz_KXv33_R8LoHUd8PCBKW1BgdSb9oUbZH19g>
    <xmx:6DQtZYivGHKiKXvA6-B_M_msZtcEkkGMXySrYrPIHSDXY7rUfA4ZSw>
    <xmx:6DQtZTqJfQRQvDh2CSKbtdQTjvG03BgLKJY5TqJ_vkazLyWZ0RTW6Q>
    <xmx:6TQtZQfZJ3dkWp0NQ2KHzJ20KmGQrbs0D2thiLZoVHt4pZf0PqP3uA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Oct 2023 09:04:39 -0400 (EDT)
Date:   Mon, 16 Oct 2023 15:04:36 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled
Message-ID: <ZS005ahNvQ/drB8I@mail-itl>
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
 <ZSz8xu8E9-02Ej8D@macbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r1P6/8hfNgVVwBfL"
Content-Disposition: inline
In-Reply-To: <ZSz8xu8E9-02Ej8D@macbook>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r1P6/8hfNgVVwBfL
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Oct 2023 15:04:36 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jan Beulich <jbeulich@suse.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled

On Mon, Oct 16, 2023 at 11:05:10AM +0200, Roger Pau Monn=C3=A9 wrote:
> On Fri, Nov 18, 2022 at 04:49:23PM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> > the table is filled. Then it disables INTx just before clearing MASKALL
> > bit. Currently this approach is rejected by xen-pciback.
> > According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
> > enabled (in other words: enabling MSI/MSI-X implicitly disables INTx).
> >=20
> > Change the logic to consider INTx disabled if MSI/MSI-X is enabled. This
> > applies to three places:
> >  - checking currently enabled interrupts type,
> >  - transition to MSI/MSI-X - where INTx would be implicitly disabled,
> >  - clearing INTx disable bit - which can be allowed even if MSI/MSI-X is
> >    enabled, as device should consider INTx disabled anyway in that case
>=20
> Is this last point strictly needed?  From the description above it
> seems Linux only cares about enabling MSI(-X) without the disable INTx
> bit set.

I'm not sure, but it seems logical to have it symmetric.

>=20
> >=20
> > Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL=
 too")
> > Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblething=
slab.com>
> > ---
> > Changes in v3:
> >  - allow clearing INTx regardless of MSI/MSI-X state, to be consistent
> >    with enabling MSI/MSI-X
> > Changes in v2:
> >  - restructure the patch to consider not only MASKALL bit, but enabling
> >    MSI/MSI-X generally, without explicitly disabling INTx first
> > ---
> >  drivers/xen/xen-pciback/conf_space.c          | 19 +++++++++++------
> >  .../xen/xen-pciback/conf_space_capability.c   |  3 ++-
> >  drivers/xen/xen-pciback/conf_space_header.c   | 21 +++----------------
> >  3 files changed, 18 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pci=
back/conf_space.c
> > index 059de92aea7d..d47eee6c5143 100644
> > --- a/drivers/xen/xen-pciback/conf_space.c
> > +++ b/drivers/xen/xen-pciback/conf_space.c
> > @@ -288,12 +288,6 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *d=
ev)
> >  	u16 val;
> >  	int ret =3D 0;
> > =20
> > -	err =3D pci_read_config_word(dev, PCI_COMMAND, &val);
> > -	if (err)
> > -		return err;
> > -	if (!(val & PCI_COMMAND_INTX_DISABLE))
> > -		ret |=3D INTERRUPT_TYPE_INTX;
> > -
> >  	/*
> >  	 * Do not trust dev->msi(x)_enabled here, as enabling could be done
> >  	 * bypassing the pci_*msi* functions, by the qemu.
> > @@ -316,6 +310,19 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *d=
ev)
> >  		if (val & PCI_MSIX_FLAGS_ENABLE)
> >  			ret |=3D INTERRUPT_TYPE_MSIX;
> >  	}
>=20
> Since we are explicitly hiding INTx now, should we also do something
> about MSI(X) being both enabled at the same time?  The spec states:
>=20
> "System configuration software sets one of these bits to enable either
> MSI or MSI-X, but never both simultaneously. Behavior is undefined if
> both MSI and MSI-X are enabled simultaneously."
>=20
> So finding both MSI and MSI-X enabled likely means something has gone
> very wrong?  Likely to be done in a separate change, just realized
> while looking at the patch context.

Pciback try to prevent such situation (that's exactly the point of
checking the current interrupt type). But if you get into such situation
somehow anyway (likely bypassing pciback), then pciback will still allow
to disable one of them, so you can fix the situation (the enforcement of
"only one type at the time" is done setting the enable bit, but you can sti=
ll
clear it).

If both MSI and MSI-X are enabled xen_pcibk_get_interrupt_type() will
return both bits set.

> > +
> > +	/*
> > +	 * PCIe spec says device cannot use INTx if MSI/MSI-X is enabled,
> > +	 * so check for INTx only when both are disabled.
> > +	 */
> > +	if (!ret) {
> > +		err =3D pci_read_config_word(dev, PCI_COMMAND, &val);
> > +		if (err)
> > +			return err;
> > +		if (!(val & PCI_COMMAND_INTX_DISABLE))
> > +			ret |=3D INTERRUPT_TYPE_INTX;
> > +	}
> > +
> >  	return ret ?: INTERRUPT_TYPE_NONE;
> >  }
> > =20
> > diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/=
xen/xen-pciback/conf_space_capability.c
> > index 097316a74126..eb4c1af44f5c 100644
> > --- a/drivers/xen/xen-pciback/conf_space_capability.c
> > +++ b/drivers/xen/xen-pciback/conf_space_capability.c
> > @@ -236,10 +236,11 @@ static int msi_msix_flags_write(struct pci_dev *d=
ev, int offset, u16 new_value,
> >  		return PCIBIOS_SET_FAILED;
> > =20
> >  	if (new_value & field_config->enable_bit) {
> > -		/* don't allow enabling together with other interrupt types */
> > +		/* don't allow enabling together with other interrupt type */
>=20
> This comment needs to be adjusted to note that we allow enabling while
> INTx is not disabled in the command register, in order to please
> Linuxes MSI(-X) startup sequence.

Ok.

> FWIW, another option would be to simply disable INTX here once MSI(-X)
> is attempted to be enabled, won't that avoid having to modify
> xen_pcibk_get_interrupt_type()?

I would rather avoid implicit changes to other bits, it may lead to hard
to debug corner cases (in this case, for example, if domU decides to
disable MSI-X later on, it would be left with INTx disabled too, so no
interrupts at all).

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--r1P6/8hfNgVVwBfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmUtNOUACgkQ24/THMrX
1yztpQgAkT8KDyx4qVFedbSwGCFp1+6KqSeKRoiCNIFk9pHjtqoW2v1uwa4NUNmn
GyqviL5BUVivtUoTFR2V/7NBzGDJNK/fMZg4k9EjibnZNuGXqz/mhk/hd6Nh2rL6
bXFVED2ba17N5IE0rj15ux1bZyNvnxATi7gEECSAS0eNrg3IaU26JxalHmuawbAy
5d5ptPgAnOYkSzoDWlFfOge2PBBmny900ZKD8BnG+A5KICnRx1GiE3FWOumUGfWO
M8nJWdj9Xnll58UvSClexi6clpr1RoqHyKX4T3B2Tk5MDkkvn7DpYPUkJ2Yv0kbv
tjqBSWCgoJXePGgZr9UwD4mnjgeVVA==
=4jLy
-----END PGP SIGNATURE-----

--r1P6/8hfNgVVwBfL--
