Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DB479ACA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjIKVT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbjIKNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:11:30 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E089E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:11:25 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 646EEFF826;
        Mon, 11 Sep 2023 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694437884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgHSeOg7Afn9CeLK8bBHh3Wcdm8cf648NndqnCrpqho=;
        b=P0SJn7a4XwNoN4uLat4oIeFtf8ya1EzokqZiW25wj/VA6y3gb9/YOkDL6xGZ101Ap5fzcy
        xCI743y4jMg/ixkYhDKfd1IxmsNNo7CoFlz6bE13croYBVNx+VRp9Cg04SR4lrIcRvsE+e
        ceH8301fX/A4zpD0EarsD+iGvUZ2CtczRDOQS/tA4jrLcFZBWSGjyglhxkhHN6P8fMaG2a
        NwpTIjyIbVT+ABaUsOsnPUGbAjaZBKC6HKrxgvuwuSYymvUw5VgaNTEcqxhL6LlhULtMn2
        RoxFlTyX8NmWuUqpWHA6EimQbBclvBJnBw8EscMpdDgmZqsbJRvv/kaCvlbFBw==
Date:   Mon, 11 Sep 2023 15:11:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Johan Jonker <jbx6244@gmail.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: rawnand: remove 'nand_exit_status_op()'
 prototype
Message-ID: <20230911151110.09cf4c00@xps-13>
In-Reply-To: <7ab06111-5208-77b2-0f09-0751de23ae66@salutedevices.com>
References: <20230823105235.609069-1-AVKrasnov@sberdevices.ru>
        <7ab06111-5208-77b2-0f09-0751de23ae66@salutedevices.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@salutedevices.com wrote on Mon, 11 Sep 2023 13:30:00 +0300:

> Please, ping

Please, -rc1 was tagged yesterday night...

> Thanks, Arseniy
> 
> On 23.08.2023 13:52, Arseniy Krasnov wrote:
> > This function is exported and its prototype is already placed in
> > include/linux/mtd/rawnand.h.
> > 
> > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > ---
> >  drivers/mtd/nand/raw/internals.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
> > index e9932da18bdd..b7162ced9efa 100644
> > --- a/drivers/mtd/nand/raw/internals.h
> > +++ b/drivers/mtd/nand/raw/internals.h
> > @@ -106,7 +106,6 @@ int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
> >  			       int oob_required, int page);
> >  int nand_write_page_raw_notsupp(struct nand_chip *chip, const u8 *buf,
> >  				int oob_required, int page);
> > -int nand_exit_status_op(struct nand_chip *chip);
> >  int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
> >  			    unsigned int len);
> >  void nand_decode_ext_id(struct nand_chip *chip);
