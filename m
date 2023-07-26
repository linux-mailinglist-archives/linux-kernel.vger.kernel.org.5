Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57872763603
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjGZMOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjGZMOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:14:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C519BF;
        Wed, 26 Jul 2023 05:14:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso68105135e9.0;
        Wed, 26 Jul 2023 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690373679; x=1690978479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/ynjO23HFdCrYklHUN+6zq8DWOUsElQ5pQJdXR+FlI=;
        b=gRQNOMEam8G5d6CAh5u/aOAw2L8qg/n/05jy0BEtwiONVwXbBUO9a/K7svGAPPNU/W
         N/ENYsH/sdaoNTT06xRmQtP+WbvPpEmBGI+4SKS0GWMpLwAnawqbG8ro08RohiGBqQSX
         RTlQtVWFbjVGSnZUNHseYPQKwB9Qc+TQswhpJWJUWnz307IM52Gw5JQof55M9rxr0/n2
         MxS6/ySN9WkJG152EmK/jnoUSOQ0UbSpqSiGM/MPmAKlWoNkbe5v0g4b+FxVvtVwqIbK
         GMhjNGoA7Gs5gqYIiX0fYojCf+gzd0f50OWXW0EqtvOUwnd+A9Tj46aRbyCYqfdJE6j9
         y95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373679; x=1690978479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/ynjO23HFdCrYklHUN+6zq8DWOUsElQ5pQJdXR+FlI=;
        b=c8HDyNSCVqK9hexnITYVtOyQvWOKbj4f4NhEiAKNxVrdETOQjxynrhfDrp1w3gTV1/
         mJnvoLZO3EnUMTMzoMuq6JO2WQGbjA4B5haaM6P3hSaoNjbT0xv4bD1FB2+Z1Z7ZOpW2
         Mei3+JzMCjrLaDzds7g4W/TFYgvLKRNeF7K4P1Hr9B5vM9sO4FdbzCKnKvar/iMzKZ1P
         lDoAk2t6+6i/CFiGEvmasIowOxbbu4uu5mwDwF9YothEPzqJ2ArNnlnO2xR9ls0ppA+G
         S5zRa+OTjhfltKOpdeE6bosdNWMUGg4t6Fb98vIWQNXXncNTP8lCR3xPJK63FTNpy657
         Ci0A==
X-Gm-Message-State: ABy/qLYZ3rYtwGD2AQAV7E2ybb77dQVdodNg8kbgHvsilCqLDFDJzSRv
        i0OqmomBz2/Uu0TImOWRAbA=
X-Google-Smtp-Source: APBJJlGWTDBiEnax8+xwNXTCKQAEQxbqt/DOcxpmSI6anxYHa8R0YllndpppRIZ+aIF1bXJJfcxjag==
X-Received: by 2002:a1c:7310:0:b0:3fb:a0fc:1ba1 with SMTP id d16-20020a1c7310000000b003fba0fc1ba1mr1284026wmb.35.1690373678427;
        Wed, 26 Jul 2023 05:14:38 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fc01189b0dsm1821361wmc.42.2023.07.26.05.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:14:38 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:14:35 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/3] net: dsa: qca8k: make learning configurable
 and keep off if standalone
Message-ID: <20230726121435.stqwc3jzjll222ck@skbuf>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-2-ansuelsmth@gmail.com>
 <ZMDXFiSFI/hyr8j6@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMDXFiSFI/hyr8j6@corigine.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:19:34AM +0200, Simon Horman wrote:
> > +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> > +				struct switchdev_brport_flags flags,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	if (flags.mask & ~BR_LEARNING)
> > +		return -EINVAL;
> 
> If I am reading things right then some implementation of this callback
> return -EINVAL when they see unexpected flags. And some seem not to
> - possibly because all flags are expected.
> 
> So I'm slightly unsure if this is correct or not.

Which ones don't? All handlers of SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS
should return -EINVAL for changes made to bridge port flags that aren't
supported.
