Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCD57FC87E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346327AbjK1Vpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjK1Vpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:45:50 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC1999;
        Tue, 28 Nov 2023 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701207951;
        bh=p68Vf+XiFbE7VsznvJCPzG9I7V5ns6s/5UKY1UqY1TA=;
        h=Date:From:To:Cc:Subject:From;
        b=mHKGwpUlQ5XEry9X+XH71jJZwoNLHut+pIxG7Yv0LFl7kTNWKDFdkWP6CqpXZwecP
         Na5owYnHg2brRWrQV+FHJQADHYBSwU4YVpsR2pWX/lvSMNOO6p2iI16vcJEk7y7Rlc
         phNQjEvCtVqQVaQRJoS9J8hcd63BR+b0FWkeOD7T9m6FboN3TC6TC2Dr6Q8TDuQo4h
         ROR61UMvdphFUEWwEG+AXEen1iKn5USbSPUqMdkRz4pE98iArKbGFEIYVhnXKqD+4H
         4fHidOkukg8+EFqgy1EmsjCKM6DkWMTgrk4wa3T/5BQPfklgeq45MAfZo8UPPmupl/
         ev9v1clGpYRPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SfwxV1YfFz4wdD;
        Wed, 29 Nov 2023 08:45:50 +1100 (AEDT)
Date:   Wed, 29 Nov 2023 08:45:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Rokosov <ddrokosov@salutedevices.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20231129084547.79c27d63@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NmrR3UJAzvlW_FwXkBTsq1F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NmrR3UJAzvlW_FwXkBTsq1F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

make[5]: *** No rule to make target 'samples/cgroup/cgroup_event_listener.c=
', needed by 'samples/cgroup/cgroup_event_listener'.  Stop.

Caused by commit

  fc2cf253aaec ("samples: introduce new samples subdir for cgroup")

I have reverted that commit (and the following one) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/NmrR3UJAzvlW_FwXkBTsq1F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVmX4sACgkQAVBC80lX
0GzUgAf/fYVj1N426VnCX8HYusU4b7ucJl5hLfYkPZ5HykaxWa5es+Gf1b2PlBHk
IW0X0cUgmyIHdwfuC+UfR1nnQuggDbV5vBs3wgdCtqkE9f/ryHTIp5SkWTA7YHJ+
CwxobfZfD2Q9fPQ7ZpVeFsUCwk7I9RT6u9pZs74+JRNqKc5HJNprVKYU6OpGOjc9
imrWab/Fipvmbg8ivvx1qS1dZWA0IHuD8YZPR39iEJKjSVIGU1hBaroYvxfG/Ww0
yWhDYSdK4diHOODbr9hfdHZBDJNyhZ8x+5eYT3TRo97eX4iT/5hCwoE4WR6OZj3u
VsMZqOAFcBCHTtc5UdCtFlJ002M8GA==
=npgA
-----END PGP SIGNATURE-----

--Sig_/NmrR3UJAzvlW_FwXkBTsq1F--
