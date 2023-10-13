Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738B7C915B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJMXfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMXfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:35:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01AA9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:35:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso1969325b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697240107; x=1697844907; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AHKDZ3XDgz4acF4+DkWVpvMtmbGAqaQVvgAwz4bhM4Y=;
        b=hMkPp69EStD3kWejd2MFFyrqD8k4pHKRS01+GAz7TEJNyhXN22W6XfcVVJLcx/2YNP
         VJZAmTy+m0Oh8AhllsOLmuRI+z+ai7O+7G211JVeSmRhEL+BRQqNTilRO3XWl+1r1YGn
         EI05wdZ6Pq/u7CigRzSZnsNGu5VClhMND5LEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240107; x=1697844907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHKDZ3XDgz4acF4+DkWVpvMtmbGAqaQVvgAwz4bhM4Y=;
        b=jBMEzQZqf2IZ1f6QpjDoRllFsxjEdketyzSflWYDGuln0ckdI18sxcHNP9lZtHYVy5
         tXfo5m4YkfrJ8iFNud/xMTVhRbFDXNQrqtmddDS3fs1STb5iV6TkERYHDe7ywCSTIwZV
         U43e6F1OKe+Wtl0ZK8kp5TzGlikhUOs6dT7TXcBBLVjb4IvgxKx6AjhdZGlcG7XXgHI8
         OA7RqYtPh9yP9cEBsvXkn6JZqkA+zLXbUvKLaCMcxlwQW1vAmyx2D7vbJvxCOLbqGx09
         eVKZTryabD8uOsNHBuzKA8cg3bv2Z53awDwvF71EUmWumdl1vzeDwBaUHi72iKWjSf82
         d8Dg==
X-Gm-Message-State: AOJu0YwZ9HHDYWob9O5A7wK4wGxtYax6zSkoMLgbbTxE9A/31jVAYzYc
        HydiBChriXeYNKL7ao8Tca871w==
X-Google-Smtp-Source: AGHT+IFVsRqeEvvb0rxG9AitDSaFC9Eo2vYmuaEaLBSRUAgTIHFNojLc8fnR5monzQ6HhXkXFzrFKg==
X-Received: by 2002:a62:8492:0:b0:68a:582b:6b62 with SMTP id k140-20020a628492000000b0068a582b6b62mr1709607pfd.7.1697240107470;
        Fri, 13 Oct 2023 16:35:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y16-20020aa793d0000000b0068fdb59e9d6sm668511pff.78.2023.10.13.16.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:35:06 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:35:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310131630.5E435AD@keescook>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
 <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
 <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
 <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:23:34PM -0700, Justin Stitt wrote:
> On Fri, Oct 13, 2023 at 2:12 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > On Fri, Oct 13, 2023 at 1:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Fri, Oct 13, 2023 at 12:53:53PM -0700, Justin Stitt wrote:
> > > > On Fri, Oct 13, 2023 at 5:22 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > > > >
> > > > > > -     for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> > > > > > -             strncpy(data + i * ETH_GSTRING_LEN,
> > > > > > -                     tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
> > > > > > -     }
> > > > > > +     for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> > > > > > +             ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
> > > > > >  }
> > > > >
> > > > > I assume you are using "%s" because tja11xx_hw_stats[i].string cannot
> > > > > be trusted as a format string? Is this indicating we need an
> > > > > ethtool_puts() ?
> > > >
> > > > Indeed, it would trigger a -Wformat-security warning.
> > > >
> > > > An ethtool_puts() would be useful for this situation.
> > >
> > > Hi Justin
> > >
> > > hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, netvsc_stats[i].name);
> > > hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, vf_stats[i].name);
> > > ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_string);
> > > ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
> > > ethernet/intel/ice/ice_ethtool.c:                       ethtool_sprintf(&p, ice_gstrings_priv_flags[i].name);
> > > ethernet/intel/igc/igc_ethtool.c:                       ethtool_sprintf(&p, igc_gstrings_stats[i].stat_string);
> > > ethernet/intel/ixgbe/ixgbe_ethtool.c:                   ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
> > > ethernet/netronome/nfp/nfp_net_ethtool.c:                       ethtool_sprintf(&data, nfp_self_test[i].name);
> > > ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&data, nfp_net_et_stats[i + swap_off].name);
> > > ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&data, nfp_net_et_stats[i - swap_off].name);
> > > ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&data, nfp_net_et_stats[i].name);
> > > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_sprintf(&p, txq_stat_names[j]);
> > > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_sprintf(&p, xdpq_stat_names[j]);
> > > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_sprintf(&p, rxq_stat_names[j]);
> > > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_sprintf(&p, tls_stat_names[j]);
> > > ethernet/amazon/ena/ena_ethtool.c:              ethtool_sprintf(&data, ena_stats->name);
> > > ethernet/amazon/ena/ena_ethtool.c:                      ethtool_sprintf(&data, ena_stats->name);
> > > ethernet/brocade/bna/bnad_ethtool.c:            ethtool_sprintf(&string, bnad_net_stats_strings[i]);
> > > ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, ionic_lif_stats_desc[i].name);
> > > ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, ionic_port_stats_desc[i].name);
> > > ethernet/hisilicon/hns/hns_dsaf_gmac.c:         ethtool_sprintf(&buff, g_gmac_stats_string[i].desc);
> > > ethernet/hisilicon/hns/hns_dsaf_xgmac.c:                ethtool_sprintf(&buff, g_xgmac_stats_string[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmxnet3_tq_dev_stats[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmxnet3_tq_driver_stats[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmxnet3_rq_dev_stats[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmxnet3_rq_driver_stats[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:              ethtool_sprintf(&buf, vmxnet3_global_stats[i].desc);
> > >
> >
> > Woah, are these all triggering -Wformat-security warnings?
> 
> Erhm, I guess -Wformat-security is turned off:
> 
> ./scripts/Makefile.extrawarn +16:
> KBUILD_CFLAGS += -Wno-format-security

Whee. This is a longer issue, but yes, it would be nice if we could get
out of the way of enabling -Wformat-security again some day.

> Kees, what do you think about this warning and the semantics of:
> 
> 1) ethtool_sprintf(&data, "%s", some[i].string);
> 2) ethtool_sprintf(&data, some[i].string);
> 3) ethtool_puts(&data, some[i].string);

I've been told that this whole ethtool API area is considered
deprecated. If that holds, then I don't think it's worth adding new
helpers to support it when ethtool_sprintf() is sufficient.

Once you're done with the strncpy->ethtool_sprintf conversions I think
it would be nice to have a single patch that fixes all of these
"%s"-less instances to use "%s". (Doing per-driver fixes for that case
seems just overly painful.)

-- 
Kees Cook
