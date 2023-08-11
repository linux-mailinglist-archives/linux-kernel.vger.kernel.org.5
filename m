Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC077871B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjHKFwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHKFww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:52:52 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8A62706;
        Thu, 10 Aug 2023 22:52:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66996FF802;
        Fri, 11 Aug 2023 05:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691733169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wSXUIypajoc4S0icVGjYQbDkDjBI1P9MywNlVtj23I=;
        b=PmmYRmeUu0kh+eimWRkM6WMlJvlNOipCNG+n3GBPb5YwukvyWEAmLAPDBLizhVxjvisxoa
        SgCcyu08SXk2ayEah/u83t3aKss5aEwR+wQsdT56z8WYSOYuG8euVJAgie68icjQdfkG6E
        DVko1i6FxzjezmGMRB2ryt20WYJ6Pjr6llIXGWUZ0idHlNqCE2O0ZyHWkZsYQorgLFhn75
        eSGcnBFKFeqeCN1eExhb0dlpcPSSAeruDS1LuKkwd7wnKIL186u82VnL93HOIAoUeEVjE+
        /2m/ph35i5PJjIzyYjH0srrpEd3V/mMh0kpyahIl9WRQDbjhYziYkvcqfeGiBQ==
Date:   Fri, 11 Aug 2023 07:52:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Stephan Wurm <stephan.wurm@a-eberle.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/7] Fix UBI Block wrt. highmem
Message-ID: <20230811075244.11c23eba@xps-13>
In-Reply-To: <20230810160019.16977-1-richard@nod.at>
References: <20230810160019.16977-1-richard@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

richard@nod.at wrote on Thu, 10 Aug 2023 18:00:11 +0200:

> Patch 1 changes UBIblock to use a copy of scsi_kmap_atomic_sg()
> for sg list processing. This patch is meant for backporting to stable.
> It makes use of kmap_atomic() and a bounce buffer because MTD/UBI IO
> can sleep.
>=20
> Patches 2 to 7 move scsi_kmap_atomic_sg() into lib/scatterlist.c,
> convert it to kmap_local(), convert all users to it and remove the
> bounce buffer from UBIblock again.

Both the idea and the implementation look nice, I don't feel skilled
enough for sending Reviewed-by here, but it seems okay at a first
glance.

Well done Richard :-)

Miqu=C3=A8l
