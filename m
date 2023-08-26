Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFCE789615
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjHZKtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjHZKt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:49:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E2212D;
        Sat, 26 Aug 2023 03:49:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c0290f0a8so218990366b.1;
        Sat, 26 Aug 2023 03:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693046953; x=1693651753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d2yXjsftcuUzA75bZAVhPZ+LaDIZTe1V2cj9oaOnDyU=;
        b=SrViTYIx/g/mj8r+DJ51eMpuHY1vH9kxvTMLJISZvCIM4tmpvoJsg4LbOpCT1SoiPf
         ayfZAGkU4cMsctGA05gO/9S5vKB9zX/dUXJEyXQbXSZAz8GErwi7mTuMrbwokpzlYfNx
         M+IZ6GufMUkoyr56/FJgJ0/BhU/vpwtA5HBafTAeQ7EQ0TMGyiEXBVdyQt1Bnk/dItx3
         AdQ9Zqf/kS3wNFsmXVE5o4scpqRqOnQ5HWYFAoFp1yjSvHBhaYMxSOruupRaPRbvwfQO
         3rKsrV1zx1oZiq2ab8fBJZD8AA+JTj0OsZpVIsns+lOE78cagFpWebwTuPu35bFJ7lnX
         tJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693046953; x=1693651753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2yXjsftcuUzA75bZAVhPZ+LaDIZTe1V2cj9oaOnDyU=;
        b=kUSDW8X9N9mgJWAOGKCxK6K4S88atNOmzj9UOETv50O+d3M5IIDuL/E8ydslBxIel2
         bMCMmvrwdl+d6+2S0FNHNIw6tV0iTpDb8Y2eB/RGDLVfkO8st9kRGuGAD1lO/OOwNsxz
         z5DHHAnItLv2YxkC9NgrtM5lsAQoE9ypON1hFnzmgimc70cUZ4BdpL4sMx2nB5GPPOys
         PKO7qR/6vPNgiqGzapQzEN3588wXRpyFXxmL7z3UreytxGtvL7Zl0xSrOLFtfxjo62Tt
         R3jdonpEmeCBw+WqNnh5POGbIaukRBJWyPKiAh6/mgO+XAE3W3LtLjgKARtrku076H25
         BfWw==
X-Gm-Message-State: AOJu0YyIrkGYTIt9vTMbwiCFuqG1HXOG8ELgKoYMu+apwP6ejc1khe/L
        564k0daw/PH8+vuv5tFA4V8=
X-Google-Smtp-Source: AGHT+IH85Tk7uXxK8xOaVQZhKDVQa0HkvDoYEBaH30kn0c1kBCN3IVvOystXZeBB4cExdCkutaDZTg==
X-Received: by 2002:a17:906:cc53:b0:9a2:5bf:8b14 with SMTP id mm19-20020a170906cc5300b009a205bf8b14mr5113130ejb.22.1693046952990;
        Sat, 26 Aug 2023 03:49:12 -0700 (PDT)
Received: from skbuf ([188.27.184.225])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906395800b00993b381f808sm2030684eje.38.2023.08.26.03.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 03:49:12 -0700 (PDT)
Date:   Sat, 26 Aug 2023 13:49:10 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Tristram.Ha@microchip.com
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, Woojung.Huh@microchip.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        lukma@denx.de
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230826104910.voaw3ndvs52yoy2v@skbuf>
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
 <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
 <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 06:48:41PM +0000, Tristram.Ha@microchip.com wrote:
> > > IMHO adding functions to MMD modification would facilitate further
> > > development (for example LED setup).
> > 
> > We already have some KSZ9477 specific initialization done in the Micrel
> > PHY driver under drivers/net/phy/micrel.c, can we converge on the PHY
> > driver which has a reasonable amount of infrastructure for dealing with
> > workarounds, indirect or direct MMD accesses etc.?
> 
> Actually the internal PHY used in the KSZ9897/KSZ9477/KSZ9893 switches
> are special and only used inside those switches.  Putting all the switch
> related code in Micrel PHY driver does not really help.  When the switch
> is reset all those PHY registers need to be set again, but the PHY driver
> only executes those code during PHY initialization.  I do not know if
> there is a good way to tell the PHY to re-initialize again.

Suppose there was a method to tell the PHY driver to re-initialize itself.
What would be the key points in which the DSA switch driver would need
to trigger that method? Where is the switch reset at runtime?
