Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C50A7B01F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjI0KdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0KdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:33:13 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99175EB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:33:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9F2DF3200A35;
        Wed, 27 Sep 2023 06:33:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Sep 2023 06:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695810790; x=1695897190; bh=lkrcTLrqA6Qjn2Pw1xJdjQCBFPJ76UGPozM
        U4OXQslg=; b=sjln5KaUlVXWrbuswKb4lmQGYwWBIXgXMiTBIJgLsDeQITIt1G+
        fnPPdt8a1zVaHN7O1YjhdbDeStk7kpuOuEmfVUITnBYVwx1uEIJCHi8G1bu2MxFc
        ymmpLjumvMy/VgIO1Vp1hCGdMT5Guly9gFZnJXrUWrUxmYrAbTc1KeQuSQmWWSCH
        xG/PRneKfe0LzX2Y2r/4avoLFBa4+ECMF9JUe6kX7kOXG4w2+aPmlUOLeX3KlpLz
        TDVgFgvxCsM5gyOkcZV49IZ0Zu+IGRlBzqudU1BtPclrxfcRK3cjLTHknLcnFWf+
        vgUsAka2O1bKmSoTVr4dk6jC4Pnz2IRg9Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695810790; x=1695897190; bh=lkrcTLrqA6Qjn
        2Pw1xJdjQCBFPJ76UGPozMU4OXQslg=; b=H7CdPAN2Xwuc2dK5MfJzRi0S/T6pe
        yc7cgaAY3UCUE9AgBC/3lWwH/R0KFFcgNdmXoKBjWJ0uR1AQsoOYHMTw4QeTDgx1
        VOU+H8v9DtFX2bgZvN6YumBCaxIl+Ffw0S1Z9xSI5Asj7rWrOcr0ynKapEs/TBQn
        M3XRwXfRFID5QtWuOp+1KL9r6DTBJMDsEkxmbnWslCCkzPqZqboUASnLWGkTWByw
        QFrJ3uqGySB+g76bEem0V+36oKk5seQQtTHPeEhfbkJiYwS1VQN51bZaTlNKszQX
        UOwKk5KHZS+ZNuEWEhDT3Z4IYlGTsWGwOMihbwg3DD37RcWPLDYGy1KjQ==
X-ME-Sender: <xms:5QQUZeL6x9GfywEivYAskIExTU15VgBm8bZ9yQAkEvuBu2nwDFayzA>
    <xme:5QQUZWL62omOA_n_iYwA9k7lPcc8cafl_nndMEqcCvfGFinwq0cNu9HPniOTlj7Fz
    glEEOCuaER0Xw>
X-ME-Received: <xmr:5QQUZev_6DR4CF1tl0URqgMzUj6vRDKBDV6KEyLfSscO9sloWicVCrrK8uvNm4rrq6Z03569pHx8HDN83jiyvReIqw9rsIx1DhY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdefgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeegffdu
    udelffekhfejleefgeekgeetieekudetveelfeduhfefheeuudfhudegffenucffohhmrg
    hinhepgigvnhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrd
    gtohhm
X-ME-Proxy: <xmx:5QQUZTaFqdj8Ee3XMoTiUJ89gXRy1TuO4vxIkQo-_yT71Zlh68vGBA>
    <xmx:5QQUZVYA6Gs6Thw-vC4gBuLr9zZ1KOP_IWOqRcBpA6URgcb2KS8vng>
    <xmx:5QQUZfAERMYPJwnDb99ghUMxaZc5Avy-7jKZXl322DSKCg6aZa4d6A>
    <xmx:5gQUZZEYLnpmSwWJ3w7iBkis6KWvpa9Zv8g9o9OSva9LZjCyeMvBQA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 06:33:08 -0400 (EDT)
Date:   Wed, 27 Sep 2023 12:33:05 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled
Message-ID: <ZRQE4jt/a1RJ0wUw@mail-itl>
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EOjJ45zJghDRhlN7"
Content-Disposition: inline
In-Reply-To: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EOjJ45zJghDRhlN7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Sep 2023 12:33:05 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jan Beulich <jbeulich@suse.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled

On Fri, Nov 18, 2022 at 04:49:23PM +0100, Marek Marczykowski-G=C3=B3recki w=
rote:
> Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> the table is filled. Then it disables INTx just before clearing MASKALL
> bit. Currently this approach is rejected by xen-pciback.
> According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
> enabled (in other words: enabling MSI/MSI-X implicitly disables INTx).
>=20
> Change the logic to consider INTx disabled if MSI/MSI-X is enabled. This
> applies to three places:
>  - checking currently enabled interrupts type,
>  - transition to MSI/MSI-X - where INTx would be implicitly disabled,
>  - clearing INTx disable bit - which can be allowed even if MSI/MSI-X is
>    enabled, as device should consider INTx disabled anyway in that case
>=20
> Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL t=
oo")
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>

Ping?

The issue pointed out by Jason was fixed in Xen:
https://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommit;h=3D913751d7af6e78d6=
5c1e2adf4887193c827f0c5e

> ---
> Changes in v3:
>  - allow clearing INTx regardless of MSI/MSI-X state, to be consistent
>    with enabling MSI/MSI-X
> Changes in v2:
>  - restructure the patch to consider not only MASKALL bit, but enabling
>    MSI/MSI-X generally, without explicitly disabling INTx first
> ---
>  drivers/xen/xen-pciback/conf_space.c          | 19 +++++++++++------
>  .../xen/xen-pciback/conf_space_capability.c   |  3 ++-
>  drivers/xen/xen-pciback/conf_space_header.c   | 21 +++----------------
>  3 files changed, 18 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciba=
ck/conf_space.c
> index 059de92aea7d..d47eee6c5143 100644
> --- a/drivers/xen/xen-pciback/conf_space.c
> +++ b/drivers/xen/xen-pciback/conf_space.c
> @@ -288,12 +288,6 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
>  	u16 val;
>  	int ret =3D 0;
> =20
> -	err =3D pci_read_config_word(dev, PCI_COMMAND, &val);
> -	if (err)
> -		return err;
> -	if (!(val & PCI_COMMAND_INTX_DISABLE))
> -		ret |=3D INTERRUPT_TYPE_INTX;
> -
>  	/*
>  	 * Do not trust dev->msi(x)_enabled here, as enabling could be done
>  	 * bypassing the pci_*msi* functions, by the qemu.
> @@ -316,6 +310,19 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
>  		if (val & PCI_MSIX_FLAGS_ENABLE)
>  			ret |=3D INTERRUPT_TYPE_MSIX;
>  	}
> +
> +	/*
> +	 * PCIe spec says device cannot use INTx if MSI/MSI-X is enabled,
> +	 * so check for INTx only when both are disabled.
> +	 */
> +	if (!ret) {
> +		err =3D pci_read_config_word(dev, PCI_COMMAND, &val);
> +		if (err)
> +			return err;
> +		if (!(val & PCI_COMMAND_INTX_DISABLE))
> +			ret |=3D INTERRUPT_TYPE_INTX;
> +	}
> +
>  	return ret ?: INTERRUPT_TYPE_NONE;
>  }
> =20
> diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xe=
n/xen-pciback/conf_space_capability.c
> index 097316a74126..eb4c1af44f5c 100644
> --- a/drivers/xen/xen-pciback/conf_space_capability.c
> +++ b/drivers/xen/xen-pciback/conf_space_capability.c
> @@ -236,10 +236,11 @@ static int msi_msix_flags_write(struct pci_dev *dev=
, int offset, u16 new_value,
>  		return PCIBIOS_SET_FAILED;
> =20
>  	if (new_value & field_config->enable_bit) {
> -		/* don't allow enabling together with other interrupt types */
> +		/* don't allow enabling together with other interrupt type */
>  		int int_type =3D xen_pcibk_get_interrupt_type(dev);
> =20
>  		if (int_type =3D=3D INTERRUPT_TYPE_NONE ||
> +		    int_type =3D=3D INTERRUPT_TYPE_INTX ||
>  		    int_type =3D=3D field_config->int_type)
>  			goto write;
>  		return PCIBIOS_SET_FAILED;
> diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xe=
n-pciback/conf_space_header.c
> index 981435103af1..fc0332645966 100644
> --- a/drivers/xen/xen-pciback/conf_space_header.c
> +++ b/drivers/xen/xen-pciback/conf_space_header.c
> @@ -104,24 +104,9 @@ static int command_write(struct pci_dev *dev, int of=
fset, u16 value, void *data)
>  		pci_clear_mwi(dev);
>  	}
> =20
> -	if (dev_data && dev_data->allow_interrupt_control) {
> -		if ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE) {
> -			if (value & PCI_COMMAND_INTX_DISABLE) {
> -				pci_intx(dev, 0);
> -			} else {
> -				/* Do not allow enabling INTx together with MSI or MSI-X. */
> -				switch (xen_pcibk_get_interrupt_type(dev)) {
> -				case INTERRUPT_TYPE_NONE:
> -					pci_intx(dev, 1);
> -					break;
> -				case INTERRUPT_TYPE_INTX:
> -					break;
> -				default:
> -					return PCIBIOS_SET_FAILED;
> -				}
> -			}
> -		}
> -	}
> +	if (dev_data && dev_data->allow_interrupt_control &&
> +	    ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE))
> +		pci_intx(dev, !(value & PCI_COMMAND_INTX_DISABLE));
> =20
>  	cmd->val =3D value;
> =20
> --=20
> 2.37.3
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--EOjJ45zJghDRhlN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmUUBOEACgkQ24/THMrX
1yzBAQf/SHf0RTHfqbq+msnyxOU14bDfbEM8oyJHi5kRnq7CbBGWTQxj2SzluNcZ
rWnV06yAeD4uolUPHsgK86pKR3JDOQ89YhVj9aCMOe/n5cwVeV7V6S7PGrnOrzTt
i6ctMcafEA7gJtSPXnPI2q6t5rqQkS1YU15U5JxKB46RA9ALJx1/gnYdkzuiLgof
L4MX81mVKmniiTot3G5krhABVsVjAJXWP+Wuh8gVApaSqrPa76hGGpxmdmTsQ3KU
HuLtIO03tkjbogleWkMjH6rR8GP317Eq8ivwjna9qovV2Usn62x/HVO+ctl3+2/7
G9/IcYUCwe0HFI0AZucdc9Om/eqpCg==
=WCCk
-----END PGP SIGNATURE-----

--EOjJ45zJghDRhlN7--
