Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEF8803913
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjLDPox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:44:52 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CF9B1B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:44:57 -0800 (PST)
Received: (qmail 384740 invoked by uid 1000); 4 Dec 2023 10:44:57 -0500
Date:   Mon, 4 Dec 2023 10:44:57 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com, tj@kernel.org, paulmck@kernel.org,
        Martin.Mueller5@de.bosch.com
Subject: Re: [PATCH v3] usb: hub: Add quirk to decrease IN-ep poll interval
 for Microchip USB491x hub
Message-ID: <caa5c2c8-7aa7-4ad0-9ad4-a58d1eceea37@rowland.harvard.edu>
References: <20231201144705.97385-1-hgajjar@de.adit-jv.com>
 <39f334d2-abe6-4b4d-a48c-b22a907c6ea6@rowland.harvard.edu>
 <2023120437-opposite-juiciness-e0dd@gregkh>
 <20231204152543.GA115715@vmlxhi-118.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204152543.GA115715@vmlxhi-118.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 04:25:43PM +0100, Hardik Gajjar wrote:
> On Mon, Dec 04, 2023 at 08:02:50AM +0100, Greg KH wrote:
> > And why not use BIT() as that's what these are.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I am considering aligning with existing quirks.
> Is it advisable to use something like HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL BIT(2)? 
> I'm thinking to submit two patches – one to replace hard values with BIT() in existing quirks and a second patch containing my changes.

That's a good idea.

Alan Stern
