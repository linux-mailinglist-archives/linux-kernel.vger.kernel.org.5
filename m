Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2EF7DBDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjJ3Qcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjJ3Qcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:32:36 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8632CE8;
        Mon, 30 Oct 2023 09:32:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C369FF813;
        Mon, 30 Oct 2023 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698683551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QLAyXBaIkFIdLrwn+vPKXEXm7n7cC52VJz2sxQkM3s=;
        b=V5MGqdlG1vkmucEzct/Xy7esxz0RpMR2Meg3pGA/tFkDGUnuXb9w8PTOgb2A35ZlwPYICj
        4qEplvV60ADIY3ibOSkdllpmdDDvAhtCnESbJQEfo6XRiGOmH1Ju9kfK0bZjoHjyVNpGTI
        Nc+V0IfKp4BWJ07EujekEI4zQa8iA/1pXNoiEMLpJsORn0JZPFnK7nKziT3Ap0LmXMKCpS
        kvwxd/C5mJ/jpGPWjbDSlWC9uo7wkYpK+Na6jf/f2KvQCmIriX2bkf82dKbVxK9eBaILg7
        wW+mhIv6FvI6+cwRPaEG4BmZ8boUnCa3Xi4wyPPc4E1w62Fo4d9Tae4leKpCqA==
Date:   Mon, 30 Oct 2023 17:32:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
Message-ID: <20231030173228.691620ca@xps-13>
In-Reply-To: <20231030103415.401ce804@canb.auug.org.au>
References: <20231030103415.401ce804@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sfr@canb.auug.org.au wrote on Mon, 30 Oct 2023 10:34:15 +1100:

> Hi all,
>=20
> Today's linux-next merge of the mtd tree got a conflict in:
>=20
>   drivers/mtd/devices/block2mtd.c
>=20
> between commit:
>=20
>   1bcded92d938 ("mtd: block2mtd: Convert to bdev_open_by_dev/path()")

I haven't seen this commit, I was not Cc'ed.

> from the vfs-brauner tree and commit:
>=20
>   ff6abbe85634 ("mtd: block2mtd: Add a valid holder to blkdev_put()")

I will drop this commit from mtd/next. Please take it through the
vfs-brauner tree as well to avoid conflicts or otherwise, Richard, can
you send an update at -rc1?

Thanks,
Miqu=C3=A8l
