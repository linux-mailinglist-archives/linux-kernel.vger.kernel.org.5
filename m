Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3377C7AD83D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjIYMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIYMuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:50:10 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C5FB;
        Mon, 25 Sep 2023 05:50:04 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RvN4k1CkSzyVk;
        Mon, 25 Sep 2023 15:49:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1695646199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFO4oLZ4/L+xeMDpfEnWa5bqoMgVe5r8XtjKJm8TBxI=;
        b=VUR0pW1uDg1MCaMC6jx1i4LfDWX1RFEiUhiUmgDkeK8ampkzkWTPFhxIcaUQ54l4hdmt16
        DX38rgczhSeGvEay+Os8odbWrDdKYHNo6oqaHD/wPRvnWoxXRsTdERLBJMQlFfncKkhUm1
        xQE7m6oHuWoP/62rPotHAEklgeTIJL4=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1695646199; a=rsa-sha256; cv=none;
        b=KNC51ieTEY9wxg3mWPVb6Fnr9aleZNzsJKNDZUcWxSN2fvPrz4fDCU8LRHtuo+M1rg0mIB
        7wKHyY0Qmmr4fQm59xV7xxQ++k0UOPKZmPt1mFuJDA+7AbDVN807M2jQyzP7bvA4pArBn0
        L4dZrqYzKCkDP0osUwtlXd7G+JBR230=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1695646199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFO4oLZ4/L+xeMDpfEnWa5bqoMgVe5r8XtjKJm8TBxI=;
        b=Wucs6lvYGm0p2mWm8bp/XtRrp41tGCg6H7z0jiuOCscfs+gR0piSxBmw3439RcA5gAFkQy
        wCAWMAhRUUfMvDMMRBmByHH2bF/7PCcrp3U0tNSrKMzTbzYCAneu69Uo2W7Ao6ZtVQEbTj
        1eDjvMrvj5rABN9u1d7oKM5vTuYBbKI=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 84BF2634C93;
        Mon, 25 Sep 2023 15:49:57 +0300 (EEST)
Date:   Mon, 25 Sep 2023 12:49:57 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Benjamin Bara <bbara93@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH WIP RFC v2 0/2] media: uapi: Add V4L2_CID_VTOTAL control
Message-ID: <ZRGB9bXX6HZ6aobi@valkosipuli.retiisi.eu>
References: <20230609-v4l2-vtotal-v2-0-cf29925f4517@skidata.com>
 <5f7873743042cb302c2cb55cdb7ea5e9b26966f0.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f7873743042cb302c2cb55cdb7ea5e9b26966f0.camel@ndufresne.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas, Benjamin,

On Thu, Jun 22, 2023 at 11:14:41AM -0400, Nicolas Dufresne wrote:
> Hi,
> 
> Le jeudi 22 juin 2023 à 09:12 +0200, Benjamin Bara a écrit :
> > Hi!
> > 
> > This series adds new controls for the vertical and horizontal total
> > size. Camera sensors usually have registers regarding the total size and
> > not the blanking size. Also user space prefers to calculate with total
> > frame sizes. Therefore, this would simplify implementations on both
> > sides and could be seen as a replacement or upgrade for V4L2_CID_VBLANK.
> > Additionally, its value is independent from format changes and therefore
> > simplifies calculations in user space.
> 
> The naming is getting more and more generic. We need to find a way to give these
> controls a name that associates them to their usage field (sensors). If we keep
> growing the control list this way, in few years it will be terribly hard to
> understand what is used for what.
> 
> What about, V4L2_CID_SENSOR_VTOTAL/HTOTAL ? I'm expecting the last bit of the
> name to come from very well known specification, otherwise, its not a great name
> either in my opinion.

These controls can, in theory at least, be used for any image data bus:
they're not related to sensors but to any source of image data on a bus.
Compare this to the LINK_FREQ control, for instance: you basically need
these to calculate the frame rate (or calculate these based on the desired
frame rate).

These configurations are often called line length (in) pixels and frame
length (in) lines, the controls could be thus V4L2_CID_LLP and
V4L2_CID_FLL, to keep them a little bit shorter.

-- 
Regards,

Sakari Ailus
