Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD3778AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjHKKGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHKKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:06:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332FE3;
        Fri, 11 Aug 2023 03:06:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf1f632b8so258121866b.1;
        Fri, 11 Aug 2023 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691748376; x=1692353176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7lW/YXkBUcWvpvzgK6uj/oFovjkT8k+XZ5cfQjC2w4=;
        b=b6Q7cyPtM/1f6Uko8HlmXe2qy+08jTEeaxTnwfh7aYsTVkr5bkZ86KhthGk97hmf+/
         NS6xEfWZ8nTNP82hFwg5OqqJ9hZP3UhvD1nGnAVDQun47FnNHfrD15i7zh5es1K+CbDC
         6YWLJAySnNQW482VIFP12cyG0vfCFi0ZYcmk8hu5qb9IWdoRmkEhaURUSGbyfO36dy5k
         V5dx/GpI7l5owy6X/K/u9INXXtCLPDNI1WDXNiZXt4n7PMSjbpLo+3TXKtdjDJvu2C32
         O8R0mNVRfrhScWfEbHhulTa1EModaNviSZvXoUr5r+QgF5NoRvsNbaakJptEk+TZkrSc
         2BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691748376; x=1692353176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7lW/YXkBUcWvpvzgK6uj/oFovjkT8k+XZ5cfQjC2w4=;
        b=UoiqU1W4+Ea1HP+yNN3ftsXebFoKeDuVU4AP7GrQZOAHwr4XnJ2zjylWnHWI0iaLg5
         MzsWic2Kx0Zxkj4PmrEzL/AQW9DIboQg18lDMB3mQiW4ppXnUloZYybXMMS0Leq/NHzI
         4zy+rPxBHj7ZHZxMSuC2fHaYJnbJzr9hcAwm8mKVq7CUgIC/NvfQB4x2N2GRv/2pYENY
         XFsvtYJQyTK/634uetRdfphYXD0kgnei7NpJsZ2BnN7xnIcTHjJhlcwelgFgHk5dcoRW
         Ag4yBNyQzPEjqfEfZsSpcN8cswemo+6IGEiKcE64oJUDi9Oj7SnxqlS7UZS9hn7G1FUN
         a5ZA==
X-Gm-Message-State: AOJu0YwH76OpAqxa8W0ehM9OYq4asb0er9Vif6qgup4cGxxJ59YI4Mw1
        /gEoUIAZyK9EGiVi/lyfcfU=
X-Google-Smtp-Source: AGHT+IF2b1UiG8V87Xzw3Jv/26TSBLDokj9WGv9hkPqOrChUZGdPAhld2ZSaMODM/gQEo7dMIloRwQ==
X-Received: by 2002:a17:906:2209:b0:99b:ed8d:de4 with SMTP id s9-20020a170906220900b0099bed8d0de4mr1428611ejs.20.1691748375781;
        Fri, 11 Aug 2023 03:06:15 -0700 (PDT)
Received: from skbuf ([188.27.184.232])
        by smtp.gmail.com with ESMTPSA id d3-20020a1709063ec300b0099bcb44493fsm2071586ejj.147.2023.08.11.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 03:06:15 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:06:13 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     alexis.lothore@bootlin.com
Cc:     =?utf-8?Q?Cl=C3=A9ment?= Leger <clement@clement-leger.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v5 3/3] net: dsa: rzn1-a5psw: add vlan support
Message-ID: <20230811100613.o77ei6updvbndkjm@skbuf>
References: <20230810093651.102509-1-alexis.lothore@bootlin.com>
 <20230810093651.102509-1-alexis.lothore@bootlin.com>
 <20230810093651.102509-4-alexis.lothore@bootlin.com>
 <20230810093651.102509-4-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810093651.102509-4-alexis.lothore@bootlin.com>
 <20230810093651.102509-4-alexis.lothore@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:36:51AM +0200, alexis.lothore@bootlin.com wrote:
> +static int a5psw_port_vlan_add(struct dsa_switch *ds, int port,
> +			       const struct switchdev_obj_port_vlan *vlan,
> +			       struct netlink_ext_ack *extack)
> +{
> +	dev_dbg(a5psw->dev, "Add VLAN %d on port %d, %s, %s\n",
> +		vid, port, tagged ? "tagged" : "untagged",
> +		pvid ? "PVID" : "no PVID");
> +}
> +
> +static int a5psw_port_vlan_del(struct dsa_switch *ds, int port,
> +			       const struct switchdev_obj_port_vlan *vlan)
> +{
> +	dev_dbg(a5psw->dev, "Removing VLAN %d on port %d\n", vid, port);
> +}

These are unnecessary, we have trace points for VLANs in net/dsa/trace.h.
