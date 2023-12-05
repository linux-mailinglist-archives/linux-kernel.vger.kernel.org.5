Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B1880432D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbjLEAQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLEAQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:16:36 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B428FF;
        Mon,  4 Dec 2023 16:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1701735390; x=1702340190; i=spasswolf@web.de;
        bh=VL1t/9uVaZa4DlkGAtw5hbWp5s6+BjMwMC+1bLEDVyI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Z56e8Z9h/QilhFNWp+AhSyyttGMVspyD7wsJoyxapum30n9e05SMQ1514MJRDCxn
         QDJ0NcfOCFuE7uAQC13mALf45mCd0vmHwX4FAyEsuNjIPAYE02SXWHuPy9rvL987A
         xojlZi2SgURHd8cbJ5tLdBZDbtOjy1T/yRESpa8ecDcwLc4zRKYcBJs1+9n7bdZ3i
         q1UUQTUR17/lBKu42AnCCrkW/mvXku+OtXHjnr9MZtfOgaGtHEW8wHYXNiXdF1hf+
         wMnOMbz5L1/HEtWNE3nlrQ1R/eOhf7afdNLDrU05S3wIX+36Bnp00We5kthmTfJXG
         umhYazFJ1c0XyMKjXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from lisa.home ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xjb-1rIrWA3nPf-010dZp; Tue, 05
 Dec 2023 01:16:30 +0100
From:   Bert Karwatzki <spasswolf@web.de>
To:     amir73il@gmail.com, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>
Cc:     axboe@kernel.dk, dhowells@redhat.com, hch@lst.de,
        jlayton@kernel.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, Bert Karwatzki <spasswolf@web.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: read_write: make default in vfs_copy_file_range() reachable
Date:   Tue,  5 Dec 2023 01:16:20 +0100
Message-Id: <20231205001620.4566-1-spasswolf@web.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130141624.3338942-4-amir73il@gmail.com>
References: <20231130141624.3338942-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lsR0wLtu1y9h5TuSODyGzZErCoDe8SKviHEzDfJiOXiPSKuy4vL
 XX2Hzr90rDrg6OgpS4GgS28SfCpYnl8DaAXaLzcrgAyAaKT9KIstf7YHL8BeaLN6EW0oEaM
 9Ba63dJI3YKXfd+BQZMVa5zAVumzJD0w/WfGufhyFofilDY4vf6v1Cc6la+c/neU9q9PZRJ
 Xn74z2ikituGkmcgnQs/w==
UI-OutboundReport: notjunk:1;M01:P0:Fw5qyBNwOzY=;JZUdk51esH23BLae3Ghg2vNQMDn
 OmIIp2QCduidy3QLGhkqN2X8gFebO4ACD4FJpCt0PHPQeI/Nnv7iBO5YPdIuWm2Ydy/9hW2vA
 M95nSSiB61Q26fkvBqzCQh6VamWJBRo0s259wEKYr60p2Nb7uir9DGHDyDYFYeVKIZHDB6S/5
 zarkdvMq79pmfMiPveCgidiMgRoTytfAjUE/1OnnrNy341/D3E3P4gVMxi7wlUbX8hOnoxhCd
 Gr1cB6SzQcXSyi3QJmhJv9OB8g0Naz1oCVAjhSEOpgsm1UrP+/68C7B1UAe9WPI4vtUpNO+7I
 oG6ogY0ig+Kl6hWA+OiOES5VQsse6DzvO65xIgn8i7UVkk2SgbcjYFI6ew/c3UBsQRPmC4rjt
 Y0SqL31QwCi2m/z4Pm0AB2kN8K69Ux2SqCe9e+P8/xpQ43r3aMtmUJM3U7wi55GBSlpBzXLNf
 cJdYYezw9Ij9orS0BUi3q3XxeC5V+Y4zCC5zwHgoZR07Nby1TDessgp0e4VqcnoZ1woqF2j+p
 NvtlVpygYCRe+rq9bba13y3udNXyG1C2lA6ecWs+kIcnHwiN1QsBsaLM3FaBpceOatcDtNmo0
 84xL6eX5i/gWW5pc+a5CryecR5xU1XcAKZiZvfWhfpbTIMhpiSJ6aQ7o7SCu7ivD06KwPJY6I
 IrEqYdxIANs++TVeCG92GDIJ5LkL7Q8agC34FaocyjVJ2RhXrMc5NB3JK4ErNTXr03sdepBTp
 gOg57DO8+j+t1RUKOeGfPdh4nHCiqeu/AJCh9abAHhj+C/to3APy1bqfo9oErn+cHUrukhIV6
 QDj6mon4Da4k0FUb+C4J7Gb8SiwdTzTWaDy4ADt4OcYdIfeaCdHC3p6N5oiDY5s8ISTcy8yjr
 B8+wytZr1p2dY9iTCG+8N5Q/cTQWRhPp80IwqK9ead+rvWidEnOnA6W2JCSQVqlj4KnUaYXl7
 mECKbQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vfs_copy_file_range() is called with (flags & COPY_FILE_SPLICE =3D=3D 0=
)
and both file_out->f_op->copy_file_range and file_in->f_op->remap_file_ran=
ge
are NULL, too, the default call to do_splice_direct() cannot be reached.
This patch adds an else clause to make the default reachable in all
cases.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 fs/read_write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index e0c2c1b5962b..3599c54bd26d 100644
=2D-- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1554,6 +1554,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, lo=
ff_t pos_in,
 		/* fallback to splice */
 		if (ret <=3D 0)
 			splice =3D true;
+	} else {
+		splice =3D true;
 	}

 	file_end_write(file_out);
=2D-
2.39.2

Since linux-next-20231204 I noticed that it was impossible to start the
game Path of Exile (using the steam client). I bisected the error to
commit 05ee2d85cd4ace5cd37dc24132e3fd7f5142ebef. Reverting this commit
in linux-next-20231204 made the game start again and after inserting
printks into vfs_copy_file_range() I found that steam (via python3)
calls this function with (flags & COPY_FILE_SPLICE =3D=3D 0),
file_out->f_op->copy_file_range =3D=3D NULL and
file_in->f_op->remap_file_range =3D=3D NULL so the default is never reache=
d.
This patch adds a catch all else clause so the default is reached in
all cases. This patch fixes the describe issue with steam and Path of
Exile.

Bert Karwatzki
