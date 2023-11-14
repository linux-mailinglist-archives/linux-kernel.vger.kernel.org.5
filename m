Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F6B7EAAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjKNHUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNHUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:20:43 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D618D;
        Mon, 13 Nov 2023 23:20:38 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83D37240008;
        Tue, 14 Nov 2023 07:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699946436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9ADHb71md8VO01SCio/dgLW3EC2SFLm2+cMwvUX1NQ=;
        b=mQXbfSemr4ksSWTwx+j5PNXvlBOhrgoRE0qJVIdDqjtztgLmPH8rskqeT6T4r0cKVQvbSK
        bACDfNjAj8w78aoVVYHkpzRL65DUy/XYHzl3D/93hfpamjA6sEmd9gAg3XRgSSMupfR5jM
        UA3pMUXOqSsc1Ozmj6n7Eopn5VqI8mHOwMxQ+XC4zuvlNwL68A0M6sgs7PpnoTvfv3lsFb
        u5aPxzber++38P6ww9iFuI98i7fb71qbO3iEem4lw0S78LFaCe3uvWOXoS4/kQDuSQ3mlg
        YDmQ8dMUrlvMN/TccDJxxTHUUskZZSLwcvQ0X48jXOhqqmW2xdZISY3t4QTvaQ==
Date:   Tue, 14 Nov 2023 08:20:35 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] driver core: Keep the supplier fwnode consistent
 with the device
Message-ID: <20231114082035.64aa8d58@bootlin.com>
In-Reply-To: <CAGETcx8-iXbWkRyVT3s4XkmQii2CSysSLedDLWn0oNLQLPM3ow@mail.gmail.com>
References: <20231113133044.55257-1-herve.codina@bootlin.com>
        <CAGETcx8-iXbWkRyVT3s4XkmQii2CSysSLedDLWn0oNLQLPM3ow@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Mon, 13 Nov 2023 12:09:43 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Mon, Nov 13, 2023 at 5:30 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
> > fwnode's consumer links") introduces the possibility to use the
> > supplier's parent device instead of the supplier itself.
> > In that case the supplier fwnode used is not updated and is no more
> > consistent with the supplier device used.  
> 
> Looks like you missed this comment from my previous reply.
> 
> Nack. It's easier to debug when you know what supplier you were
> pointing to in DT that triggered the creation of the device link.
> 
> It can get confusing real quick otherwise.

Sorry,
In the next iteration, I will keep the original supplier handle for
debug prints.

Regards,
Hervé
