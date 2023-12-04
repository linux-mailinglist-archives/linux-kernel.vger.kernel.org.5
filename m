Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9B8034ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjLDNah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjLDNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB22A1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701696640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxoqRDgdXk5Yr1EiBpyguZ5lcj/kgoCW2/8o6Ow1dEg=;
        b=ikGDSC18/HqnXOgAeVIRYxkARn13FqIsC5jSusEYJQCpAXV0PNXq8HrW8Nu+aj7TvFNVzT
        pjhZNykA97yLqkozOuaazdL3bZzdP2SvV+9xfKkD5+70pk8rzDppP0d8hRP9gniqfekPEt
        ovT6bdBscY4IKWnJtbCOgc030Mm1dm0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-EhQep9JEO_COc-NdK34F1A-1; Mon, 04 Dec 2023 08:30:36 -0500
X-MC-Unique: EhQep9JEO_COc-NdK34F1A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C36F185A78E;
        Mon,  4 Dec 2023 13:30:36 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0B73492BFC;
        Mon,  4 Dec 2023 13:30:35 +0000 (UTC)
Date:   Mon, 4 Dec 2023 08:30:32 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kernel test robot <lkp@intel.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, pbonzini@redhat.com
Subject: Re: drivers/block/virtio_blk.c:570:68: warning: '%d' directive
 output may be truncated writing between 1 and 11 bytes into a region of size
 7
Message-ID: <20231204133032.GA1469867@fedora>
References: <202312041509.DIyvEt9h-lkp@intel.com>
 <20231204040038-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fTQDD8oZaQ/Bt8qL"
Content-Disposition: inline
In-Reply-To: <20231204040038-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fTQDD8oZaQ/Bt8qL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 04:02:07AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 04, 2023 at 04:56:35PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
> > commit: 4e0400525691d0e676dbe002641f9a61261f1e1b virtio-blk: support po=
lling I/O
> > date:   1 year, 6 months ago
> > config: x86_64-buildonly-randconfig-006-20230906 (https://download.01.o=
rg/0day-ci/archive/20231204/202312041509.DIyvEt9h-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20231204/202312041509.DIyvEt9h-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312041509.DIyvEt9h-l=
kp@intel.com/
> >=20
> > All warnings (new ones prefixed by >>):
> >=20
> >    drivers/block/virtio_blk.c: In function 'init_vq':
> > >> drivers/block/virtio_blk.c:570:68: warning: '%d' directive output ma=
y be truncated writing between 1 and 11 bytes into a region of size 7 [-Wfo=
rmat-truncation=3D]
> >      570 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "re=
q_poll.%d", i);
> >          |                                                             =
       ^~
> >    drivers/block/virtio_blk.c:570:58: note: directive argument in the r=
ange [-2147483648, 65534]
> >      570 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "re=
q_poll.%d", i);
> >          |                                                          ^~~=
~~~~~~~~~~
> >    drivers/block/virtio_blk.c:570:17: note: 'snprintf' output between 1=
1 and 21 bytes into a destination of size 16
> >      570 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "re=
q_poll.%d", i);
> >          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
> >=20
> >=20
> > vim +570 drivers/block/virtio_blk.c
> >=20
> >    511=09
> >    512	static int init_vq(struct virtio_blk *vblk)
> >    513	{
> >    514		int err;
> >    515		int i;
> >    516		vq_callback_t **callbacks;
> >    517		const char **names;
> >    518		struct virtqueue **vqs;
> >    519		unsigned short num_vqs;
> >    520		unsigned int num_poll_vqs;
> >    521		struct virtio_device *vdev =3D vblk->vdev;
> >    522		struct irq_affinity desc =3D { 0, };
> >    523=09
> >    524		err =3D virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> >    525					   struct virtio_blk_config, num_queues,
> >    526					   &num_vqs);
> >    527		if (err)
> >    528			num_vqs =3D 1;
> >    529=09
> >    530		if (!err && !num_vqs) {
> >    531			dev_err(&vdev->dev, "MQ advertised but zero queues reported\n"=
);
> >    532			return -EINVAL;
> >    533		}
> >    534=09
> >    535		num_vqs =3D min_t(unsigned int,
> >    536				min_not_zero(num_request_queues, nr_cpu_ids),
> >    537				num_vqs);
> >    538=09
> >    539		num_poll_vqs =3D min_t(unsigned int, poll_queues, num_vqs - 1);
> >    540=09
> >    541		vblk->io_queues[HCTX_TYPE_DEFAULT] =3D num_vqs - num_poll_vqs;
> >    542		vblk->io_queues[HCTX_TYPE_READ] =3D 0;
> >    543		vblk->io_queues[HCTX_TYPE_POLL] =3D num_poll_vqs;
> >    544=09
> >    545		dev_info(&vdev->dev, "%d/%d/%d default/read/poll queues\n",
> >    546					vblk->io_queues[HCTX_TYPE_DEFAULT],
> >    547					vblk->io_queues[HCTX_TYPE_READ],
> >    548					vblk->io_queues[HCTX_TYPE_POLL]);
> >    549=09
> >    550		vblk->vqs =3D kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KE=
RNEL);
> >    551		if (!vblk->vqs)
> >    552			return -ENOMEM;
> >    553=09
> >    554		names =3D kmalloc_array(num_vqs, sizeof(*names), GFP_KERNEL);
> >    555		callbacks =3D kmalloc_array(num_vqs, sizeof(*callbacks), GFP_KE=
RNEL);
> >    556		vqs =3D kmalloc_array(num_vqs, sizeof(*vqs), GFP_KERNEL);
> >    557		if (!names || !callbacks || !vqs) {
> >    558			err =3D -ENOMEM;
> >    559			goto out;
> >    560		}
> >    561=09
> >    562		for (i =3D 0; i < num_vqs - num_poll_vqs; i++) {
> >    563			callbacks[i] =3D virtblk_done;
> >    564			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> >    565			names[i] =3D vblk->vqs[i].name;
> >    566		}
> >    567=09
> >    568		for (; i < num_vqs; i++) {
> >    569			callbacks[i] =3D NULL;
> >  > 570			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
> >    571			names[i] =3D vblk->vqs[i].name;
> >    572		}
> >    573=09
> >    574		/* Discover virtqueues and write information to configuration. =
 */
> >    575		err =3D virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &=
desc);
> >    576		if (err)
> >    577			goto out;
> >    578=09
> >    579		for (i =3D 0; i < num_vqs; i++) {
> >    580			spin_lock_init(&vblk->vqs[i].lock);
> >    581			vblk->vqs[i].vq =3D vqs[i];
> >    582		}
> >    583		vblk->num_vqs =3D num_vqs;
> >    584=09
> >    585	out:
> >    586		kfree(vqs);
> >    587		kfree(callbacks);
> >    588		kfree(names);
> >    589		if (err)
> >    590			kfree(vblk->vqs);
> >    591		return err;
> >    592	}
> >    593=09
> >=20
> > --=20
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
>=20
> Stefan, Paolo,
> It's a false positive but do we want to fix it? Make i unsigned?

It's a false positive:

That maximum number of virtqueues is 65535. That's 5 characters. The
maximum value of num_poll_vqs is actually 65534 because it's capped at
num_vqs - 1.

The warning reveals that the analysis thinks i can be negative:

  drivers/block/virtio_blk.c:570:58: note: directive argument in the range =
[-2147483648, 65534]

It can't because of num_poll_vqs =3D min_t(unsigned int, poll_queues,
num_vqs - 1).

VQ_NAME_LEN is 16, so 9 bytes are used for "req_poll." and the NUL
terminator:

  snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);

9 + 5 =3D 14 is always less than VQ_NAME_LEN (16), so it looks like a
false positive.

That said, it's still worth cleaning up the types because they are
inconsistent:

  unsigned short num_vqs;
  unsigned int num_poll_vqs;

and using "%d" for an unsigned value also contributes to the problem.

I'll send a patch.

Stefan

--fTQDD8oZaQ/Bt8qL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt1HgACgkQnKSrs4Gr
c8hQGQgAvC3ypf09nxspqWWmTwKQ5WPNuYK6tbKgobVobv/Nt4xTgQrwfPqw8t18
m9ULsVX8BnDdbsfub1kpMubgs4+FPA8mISHgJ1SbLpZgOnL15FXIisvAt8qvmnJx
0YjALwS45322iYDa/Dm7VBQhxWw+hXjME+LCu2Qo3EKQ7lNjutfB7cU47KiE2wyT
nH+toBH87ogKD0xvFg+Ste2A6mt129e2Ci1ed1ORwhbcWCXqGlurjDTF7RpGqmlS
DF2rw9PNHjcNEYWKx84liDFJ/6x3l1/pEtjzaYHn8MZlSJ31UrgUyUKaz1z2U7Gl
iatD64or1r4StlZmOBtZlMHrhsrIWw==
=aXtt
-----END PGP SIGNATURE-----

--fTQDD8oZaQ/Bt8qL--

