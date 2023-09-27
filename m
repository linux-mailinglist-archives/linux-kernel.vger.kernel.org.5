Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4691C7B011E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjI0Jz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjI0Jzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:55:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6E31A7;
        Wed, 27 Sep 2023 02:55:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bb9cdso107558995e9.0;
        Wed, 27 Sep 2023 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695808535; x=1696413335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/HYhwZ/7bxR1wXXL8tJKudSxvRyVwCadBP+II+DAtS8=;
        b=XuptnEBF7hl1sQfLPXhbeyUPtD1ajiOeHYapuV185KYU8gzl5Iy9+jB3qvXUUlhfr5
         8O5QVVu8pAyAAd3JGkV2TYbKCgJAXBVlvnXW1JwbEXNALx11mba2bSfypREUIg5Kft6C
         is9gJGVlHHTlIg4RlS33naKxdxXYqBqe5S3BAZUXt++dum+8fue0DcRcoOzHfVje4Qf8
         npPwyoaoexZNxWglqRVDuakZ+Pvyq62SoRibXlDFXFsQNMTu83tXbB6EvGn4bmV0TtJ8
         MXiBEAoEZzghG5n00YOYH/tZiouhLpiK4Ys0p/jSbnfTdOipYPvQxVn6q9e8b671RgmL
         4cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695808535; x=1696413335;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HYhwZ/7bxR1wXXL8tJKudSxvRyVwCadBP+II+DAtS8=;
        b=LcLb2cRN3L+bFxLv3WcheCWY999j1MpSO4TJlFg7oW2SVOO/UEgiJ2cWu4qb9DjokJ
         EY8g9yp2NY4eZdpvqISwzb297Z19KouIxJ2jwY2FYCk9qQk0YcKzSQk4GgHZSQCSVE9K
         kKaO6XOsK7jDybv4mRO5eC/i016qTBjQydg9ioXJONt2reeKf+dSeQaW+iXIU88Xy1tC
         ob/NuZUDBE7M2IsVbvhcp/0EeEK/0VXzkJFUnFkQnlHFvjxTGCzCnTjlEuj0LDW7x2br
         Gizyf3R2XCIOE2MbfmmeFncCyU/DzHMs3T/LyLCW59eXyl61WYTMts954TkbtM/9ZYQJ
         oZ6g==
X-Gm-Message-State: AOJu0Yy70FRK2JGCavV56FEmY6hDJ3aERBCSfhuVILinAQ+zjuXTieqm
        rVYuXnJ+n7OPKBrqXBjm5o8=
X-Google-Smtp-Source: AGHT+IFjbKyRaaXwH6Cw/tAjqVxx4RVo2vtMmj/5lGv/qxpdVvrhcgHhsiOEDCC757jGv/sr3NmW0g==
X-Received: by 2002:a05:600c:240a:b0:402:e6a2:c8c7 with SMTP id 10-20020a05600c240a00b00402e6a2c8c7mr1443000wmp.7.1695808535196;
        Wed, 27 Sep 2023 02:55:35 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id z5-20020a7bc7c5000000b004060f0a0fd5sm4667343wmk.13.2023.09.27.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:55:34 -0700 (PDT)
Message-ID: <6513fc16.7b0a0220.d972c.48cf@mx.google.com>
X-Google-Original-Message-ID: <ZRP8FC7KLj4T4iKC@Ansuel-xps.>
Date:   Wed, 27 Sep 2023 11:55:32 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: sfp: add quirk for Fiberstone
 GPON-ONU-34-20BI
References: <20230919124720.8210-1-ansuelsmth@gmail.com>
 <ZQmkv9o329m98CUG@shell.armlinux.org.uk>
 <5615a39b3402e7499fd531c928845e102fba6f1c.camel@redhat.com>
 <ZRP7FU3BglzFBfgX@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRP7FU3BglzFBfgX@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:51:17AM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 21, 2023 at 04:40:45PM +0200, Paolo Abeni wrote:
> > Hi Russel,
> > 
> > On Tue, 2023-09-19 at 14:40 +0100, Russell King (Oracle) wrote:
> > > On Tue, Sep 19, 2023 at 02:47:20PM +0200, Christian Marangi wrote:
> > > > Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
> > > > NRZ in their EEPROM.
> > > > 
> > > > The module also require the ignore tx fault fixup similar to Huawei MA5671A
> > > > as it gets disabled on error messages with serial redirection enabled.
> > > 
> > > I'll send you shortly a different approach for the "ignore tx fault"
> > > thing that I'd like you to test please.
> > 
> > Said patch is not blocking this one, am I correct?
> 
> Correct, but Christian has not responded in any way despite me sending
> him the patch that I'd like tested, which is very disappointing.
>

I'm with you with the disappointment... I was helping a guy adding
support for this upstream and then magically disappeared... Tried to
send private email asking to test your followup patch but still no
response... Sorry for not answering your email, was hoping to have a
response and just give you a positive feedback but I think this won't
come...

> This is what I fear - that merging his patch removes the incentive to
> test my patch. Oh well, I guess I will just send my patch that I can't
> test to be merged anyway, and to hell with it. If it breaks this and
> other modules, I'm sure someone will eventually send a report about
> that.

-- 
	Ansuel
