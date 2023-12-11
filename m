Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2780D3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbjLKR1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbjLKR1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:27:46 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51767C4;
        Mon, 11 Dec 2023 09:27:52 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso4697788e87.0;
        Mon, 11 Dec 2023 09:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702315670; x=1702920470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OO0GQljarECteBeseBCGP9zfJso+D2EETifrGOypSaw=;
        b=i/yfQHxwoo7e7B/ud9SBf/3RYGyPO2oN5GMqAISVPSQhVRY+lYreJZPmJBc/Ilb1hk
         jHFaRXap91p6D49jTMoiGwG8uQPctWl4v7Oc6GTpQqprI+/sh3qj94PkZaXtBKyREFnF
         t/J+iPtGp9rU1ZTAJgY8hcI9JmaR1syUCvVfR8itRgflb0eBMfTPwX81f46C2tP04jGJ
         fJxiDGy+gJhu9elo4luft0b+uNh4xU/MfM6huTCntKQ68XdTNDFxNiV2vAKqkNVHJV/h
         9KnR6EAdldedUxKkWsuYies8vMPu1D6Jx6rpjRru8UE79e+MDsWgYU3LXfmTFBqYP0wr
         +DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315670; x=1702920470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OO0GQljarECteBeseBCGP9zfJso+D2EETifrGOypSaw=;
        b=o0Dh0/4ocjuNB0VRSXzvAA/zl4nCmoUBwa99OZHYKLkiZKorBMriJU/tOxQ5Tr0URc
         ejxij65u5U+7lDSOLVN7+Eqa1jgxrTTjTHXK92oCMRu0qZp2pDlrHOUjB3Jx6DlPVNHf
         S3F9qMSGrzAbrfa9LvDxO3K3yQO9GAxFGemjtAWIsJwTF/wtY8408sYkbQYJV7KWEjy3
         ipmApcklHiQ0Lzclc68u3QFOSheLrEN1uQ8szJmU1kfrPQPg8W7fzbYqlEl3hfQmJ52U
         Wxe0a/w+W/heBk67NAw8tjSoXU2fyQ0mNopnn3XcDn+t/LlQSZcAx4eQOuiWeXSGNKrU
         +VuQ==
X-Gm-Message-State: AOJu0YxOGEz9uUd8ONbibZjjD7XRy01IxDc2HGycspDPGJ3H+uXSFPo5
        FVxvQ3YqkZnHVNLGwZboyCNrmZMnx7M=
X-Google-Smtp-Source: AGHT+IFUg4ywpvNcYPrUuDPc0QKX6EBfk9n5LgjF6r7DuqftMLpNUtqDdaOY3KOuOLNJ19ftSGKBQA==
X-Received: by 2002:a05:6512:b95:b0:50c:2177:f184 with SMTP id b21-20020a0565120b9500b0050c2177f184mr3648357lfv.17.1702315670061;
        Mon, 11 Dec 2023 09:27:50 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b0050d14ce3958sm1072052lfs.81.2023.12.11.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:27:49 -0800 (PST)
Date:   Mon, 11 Dec 2023 20:27:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <hpqssnt7odmuuyhsljuqovmwatdjz4s6kix6abq7lrvyciawy5@5ypscmmivnmh>
References: <20231207-stmmac-no-mdio-node-v3-1-34b870f2bafb@redhat.com>
 <jz6ot44fjkbmwcezi3fkgqd54nurglblbemrchfgxgq6udlhqz@ntepnnzzelta>
 <hxds75erxqcfkufxnfbyo2up4b4jeicmi3f5xr6qlb3yf7fe76@4byeq62jhu4o>
 <hgz3pt625kggix6kzincohw7kr2okcumrwfkmjgiauw2yvhrzt@ekeygo4b7k3b>
 <h5ucipgjtsesrz3jyul5xohu4pqom56v6ayx7aonnfesret3ht@wmblmndj6zir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h5ucipgjtsesrz3jyul5xohu4pqom56v6ayx7aonnfesret3ht@wmblmndj6zir>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:50:29AM -0600, Andrew Halaney wrote:
> On Fri, Dec 08, 2023 at 06:07:06PM +0300, Serge Semin wrote:
> > On Thu, Dec 07, 2023 at 05:07:24PM -0600, Andrew Halaney wrote:
> > > On Fri, Dec 08, 2023 at 01:16:12AM +0300, Serge Semin wrote:
> > > > On Thu, Dec 07, 2023 at 03:12:40PM -0600, Andrew Halaney wrote:
> > > > > The stmmac_dt_phy() function, which parses the devicetree node of the
> > > > > MAC and ultimately causes MDIO bus allocation, misinterprets what
> > > > > fixed-link means in relation to the MAC's MDIO bus. This results in
> > > > > a MDIO bus being created in situations it need not be.
> > > > > 
> > > > > Currently a MDIO bus is created if the description is either:
> > > > > 
> > > > >     1. Not fixed-link
> > > > >     2. fixed-link but contains a MDIO bus as well
> > > > > 
> > > > > The "1" case above isn't always accurate. If there's a phy-handle,
> > > > > it could be referencing a phy on another MDIO controller's bus[1]. In
> > > > > this case currently the MAC will make a MDIO bus and scan it all
> > > > > anyways unnecessarily.
> > > > > 
> > > > > There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> > > > > be created and scanned for a phy. This case can also be inferred from
> > > > > the platform description by not having a phy-handle && not being
> > > > > fixed-link. This hits case "1" in the current driver's logic.
> > > > > 
> > > > > Let's improve the logic to create a MDIO bus if either:
> > > > > 
> > > > 
> > > > >     - Devicetree contains a MDIO bus
> > > > >     - !fixed-link && !phy-handle (legacy handling)
> > > > 
> > > > If what you suggest here is a free from regressions semantics change
> > > > (really hope it is) I will be with both my hands for it. This will
> > > > solve the problem we have with one of our device which doesn't have
> > > > SMA interface (hardware designers decided to save ~4K gates of the
> > > > chip area) but has a PHY externally attached to the DW XGMAC<->XPCS
> > > > interface. PHY is accessible via a GPIO-based MDIO bus. BTW having no
> > > > SMA interface available on a DW *MAC device but creating the MDIO-bus
> > > > on top of the non-existent SMA CSRs anyway causes having _32_ dummy
> > > > PHYs created with zero IDs.
> > > 
> > 
> > > I hope it is regression free! I have tested both the [1] and [2] cases
> > > (I hacked up the devicetree for [1] to make it look like [2]) without
> > > any issue.
> > > 
> > 
> > I doubt you could have tested it on all the possible hardware the
> > STMMAC driver supports. The problem is that the DT-bindings thing is a
> > kind of contract which can't be changed that easily. It's like ABI but
> > for the hardware description so the kernel would bootup correctly on
> > the platforms with the old DT blobs. But if the change isn't that
> > critical, if the device-tree sources in the kernel fit to the updated
> > semantics, if the networking subsystem maintainers aren't against it
> > and I guess with the Rob, Krzysztof or Conor blessing (at least it
> > won't hurt to add them to the Cc-list together with the devicetree
> > mailing-list), then it will likely be accepted.
> 

> To be clear, I don't think we're violating the dt-binding ABI contract
> here. My intention is that all the existing use cases continue to work,
> and this just improves one use case. I did a write up
> over on v2 about the use cases I see and the current logic vs what
> changes with this patch series:
> 
>     https://lore.kernel.org/netdev/plvbqgi2bwlv5quvpiwplq7cxx6m5rl3ghnfhuxfx4bpuhyihl@zmydwrtwdeg6/
> 
> Please comment if you think I have broken some backwards
> compatibility.

To shortly sum up so I didn't miss something. Current semantics of the
MDIO-bus registration is:
if !fixed-link || mdio_node_present
    create MDIO-bus
and the semantics of the PHY auto-probe (legacy) is:
if !(fixed-link || mdio_node_present || phy_node_present)
    auto-probe PHY

You are changing the MDIO-bus creation semantics to:
if !(fixed-link || phy_node_present) || mdio_node_present
    create MDIO-bus
with no change in the PHY auto-probe semantics:
if !(fixed-link || mdio_node_present || phy_node_present)
    auto-probe PHY

So the change is that if a PHY-handle is specified the MDIO-bus won't
be created with the rest conditions being the same.

The only concern I had was the so called legacy case and a possibility
to have MDIO-bus with other than PHY devices. Based on the pseudo-code
above the former case won't be affected since having PHY-node
specified didn't triggered MDIO-bus auto-probe even before your
change. The later case concerns for instance the DW XPCS devices which
on some platforms could be found on the DW MAC MDIO bus with not
having PHY living on that bus. But DW XPCS auto-probing currently is
only supported by the non-OF platforms (it's Intel). Thus your change
is supposed to be safe here too.

So to speak AFAICS from the STMMAC MDIO OF stuff your solution isn't
supposed to cause regressions and break the current DTs backward
compatibility indeed.

Regarding the ideal implementation. What could be much better is to
implement the next semantics:
if SMA-capability-detected &&
   (!mdio_node_present || (mdio_node_present && mdio_node_enabled))
    create MDIO-bus
and preserve the PHY auto-probe semantics for backwards compatibility.
Regarding the SMA-capability flag, it has been presented since DW GMAC
v3.50, so since very much early DW MAC releases. But even for the
early devices I think it could be auto-detected by checking the SMA
CSRs writability. At least DW XGMAC AFAICS has the command CSR not
writable if SMA is unavailable.

But I guess it's a matter of another patch.

> If I _could_ break compatibility, I'd make everyone
> describe their busses entirely... but as you said that's against the
> spirit of dt-bindings and would upset a lot of people. That's why I've
> left the "!fixed-link && !phy-handle (legacy handling) logic :)
> 
> > 
> > > Sorry, I don't have any docs for stmmac hardware so this might be
> > > answered in there (or just common net knowledge that I can't find
> > > online)... what's SMA stand for? I assume it's the MDIO interface.
> > 
> > Right. Synopsys names the MDIO-bus interface as Station Management
> > Agent MDIO module.
> > 
> > > 
> > > I agree though, if you have a phy-handle and no mdio node in your
> > > devicetree this patch series should bail out without registering a bus
> > > in stmmac_mdio_register().
> > 
> > On the other hand why would the MDIO-bus needed in such case? If the
> > phy-handle property is specified with no MDIO-bus DT-subnode, then it
> > will point out to a PHY residing an external bus. The only case I can
> > imagine though is that the DW XPCS device could be still auto-detected
> > on the internal SMA-MDIO-bus. But the only driver which currently has
> > XPCS auto-detection activated is the Intel glue layer (see
> > dwmac-intel.c and has_xpcs flag), but it doesn't use DT interface
> > since it handles a PCIe-based device.  So this case is out of
> > brackets.
> 
> Agreed, I think making the bus is not needed in the driver as is in that
> case.
> 

> I'd like to think (but am not sure) that when a devicetree based DW XPCS
> description comes around it will allow you to describe it exactly
> instead of doing auto-detection (i.e. something like phy-handle), but I
> am not very familiar with PCS and friends in the stack so that may be a
> crude extension from my knowledge of MDIO.

Right, there is a generic property for that - "pcs-handle". Last week
I submitted a series which makes it supported on the STMMAC and XPCS
drivers.

-Serge(y)

> 
> Thanks,
> Andrew
> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > Below upstream devicetree snippets can be found that explain some of
> > > > > the cases above more concretely.
> > > 
> > > <snip>
> > > 
> > > > > -	if (mdio) {
> > > > > -		plat->mdio_bus_data =
> > > > > -			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
> > > > > -				     GFP_KERNEL);
> > > > 
> > > > > +	/* Legacy devicetrees allowed for no MDIO bus description and expect
> > > > > +	 * the bus to be scanned for devices. If there's no phy or fixed-link
> > > > > +	 * described assume this is the case since there must be something
> > > > > +	 * connected to the MAC.
> > > > > +	 */
> > > > > +	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
> > > > > +	if (legacy_mdio)
> > > > > +		dev_info(dev, "Deprecated MDIO bus assumption used\n");
> > > > > +
> > > > > +	if (plat->mdio_node || legacy_mdio) {
> > > > > +		plat->mdio_bus_data = devm_kzalloc(dev,
> > > > 
> > > > Special thanks for adding the comment above this code. It will really
> > > > save time of figuring out why MDIO-bus needs to be created anyway.
> > > > 
> > > > > +						   sizeof(struct stmmac_mdio_bus_data),
> > > > 
> > > > Should v4 is required I would suggest to change this to
> > > > sizeof(*plat->mdio_bus_data).
> > > > 
> > > > Anyway feel free to add:
> > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > 
> > > > -Serge(y)
> > > 
> > 
> > > Sure I will spin v4 to pick that up, thanks for catching it. I'll also
> > > improve the motivation in the commit message a hair more per Andrew
> > > Lunn's request over here on v2 (and will hold off a little bit just to
> > > make sure reviews come in before a respin):
> > > 
> > >     https://lore.kernel.org/netdev/e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch/
> > 
> > Ok. Thanks.
> > 
> > -Serge(y)
> > 
> > > 
> > > Thanks,
> > > Andrew
> > > 
> > 
> 
