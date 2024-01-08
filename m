Return-Path: <linux-kernel+bounces-20115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79B8279C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D39DB21750
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A9D54BE9;
	Mon,  8 Jan 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Iwdyz5Y5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB055776;
	Mon,  8 Jan 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704747403;
	bh=2KCdXeK1HqlhdM+/mnvpFC4ncTtv081xX71UeQcp5sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iwdyz5Y5s+OqWgdfhw9hYUk2BnqpYO1Mvuj1QAAaMWyw6KwMgyXEQLti+DkQVBziN
	 vZi62INCkOqLUpNSVRLH9L35LzZPpknAG0otW8QIpBDpXkIZi2w7Q7rXO8pEOzcl0Y
	 lP09dC7iMBtWPJ8VQGuPvFAw9wRtj2ooEsqfALKen5o2BF8X+VEQ3wLmC/DsNpJB2S
	 rN0HXbJWTYjpXyaUiHbWWFR3yzxgmCo4vkOIgEyDBCVVhJuFcPC/rjZglxxpY1UdLS
	 dpuxFVofJnFJtjJFISf57eYeZjNFhLuFCMwPqj7l7PqeEUIwxizyUGq5rBDPOMRJ8/
	 xYKi1+kHxy3bQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T85vv1HPBz4wyV;
	Tue,  9 Jan 2024 07:56:43 +1100 (AEDT)
Date: Tue, 9 Jan 2024 07:56:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Qu Wenruo <wqu@suse.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20240109075642.43a10c35@canb.auug.org.au>
In-Reply-To: <20231207103213.555cc6b5@canb.auug.org.au>
References: <20231207103213.555cc6b5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zCjY7qNInrID8O53k+q7+Th";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zCjY7qNInrID8O53k+q7+Th
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 7 Dec 2023 10:32:13 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/btrfs/extent_io.c
>=20
> between commits:
>=20
>   16aee93de711 ("btrfs: migrate to use folio private instead of page priv=
ate")
>   042eab832c43 ("btrfs: refactor alloc_extent_buffer() to allocate-then-a=
ttach method")
>=20
> from the btrfs tree and commit:
>=20
>   600f111ef51d ("fs: Rename mapping private members")
>=20
> from the vfs-brauner tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/btrfs/extent_io.c
> index 5cae7884e8d9,3431a53bf3fd..000000000000
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@@ -881,13 -870,13 +881,13 @@@ static int attach_extent_buffer_page(st
>   	 * will not race with any other ebs.
>   	 */
>   	if (page->mapping)
> - 		lockdep_assert_held(&page->mapping->private_lock);
> + 		lockdep_assert_held(&page->mapping->i_private_lock);
>  =20
>   	if (fs_info->nodesize >=3D PAGE_SIZE) {
>  -		if (!PagePrivate(page))
>  -			attach_page_private(page, eb);
>  +		if (!folio_test_private(folio))
>  +			folio_attach_private(folio, eb);
>   		else
>  -			WARN_ON(page->private !=3D (unsigned long)eb);
>  +			WARN_ON(folio_get_private(folio) !=3D eb);
>   		return 0;
>   	}
>  =20
> @@@ -1750,9 -1736,9 +1750,9 @@@ static int submit_eb_subpage(struct pag
>   		 * Take private lock to ensure the subpage won't be detached
>   		 * in the meantime.
>   		 */
> - 		spin_lock(&page->mapping->private_lock);
> + 		spin_lock(&page->mapping->i_private_lock);
>  -		if (!PagePrivate(page)) {
>  +		if (!folio_test_private(folio)) {
> - 			spin_unlock(&page->mapping->private_lock);
> + 			spin_unlock(&page->mapping->i_private_lock);
>   			break;
>   		}
>   		spin_lock_irqsave(&subpage->lock, flags);
> @@@ -1826,9 -1811,9 +1826,9 @@@ static int submit_eb_page(struct page *
>   	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
>   		return submit_eb_subpage(page, wbc);
>  =20
> - 	spin_lock(&mapping->private_lock);
> + 	spin_lock(&mapping->i_private_lock);
>  -	if (!PagePrivate(page)) {
>  +	if (!folio_test_private(folio)) {
> - 		spin_unlock(&mapping->private_lock);
> + 		spin_unlock(&mapping->i_private_lock);
>   		return 0;
>   	}
>  =20
> @@@ -3070,13 -3054,12 +3070,13 @@@ static int extent_buffer_under_io(cons
>  =20
>   static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct pag=
e *page)
>   {
>  +	struct folio *folio =3D page_folio(page);
>   	struct btrfs_subpage *subpage;
>  =20
> - 	lockdep_assert_held(&page->mapping->private_lock);
> + 	lockdep_assert_held(&page->mapping->i_private_lock);
>  =20
>  -	if (PagePrivate(page)) {
>  -		subpage =3D (struct btrfs_subpage *)page->private;
>  +	if (folio_test_private(folio)) {
>  +		subpage =3D folio_get_private(folio);
>   		if (atomic_read(&subpage->eb_refs))
>   			return true;
>   		/*
> @@@ -3093,18 -3076,17 +3093,18 @@@ static void detach_extent_buffer_page(s
>   {
>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
>   	const bool mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
>  +	struct folio *folio =3D page_folio(page);
>  =20
>   	/*
>  -	 * For mapped eb, we're going to change the page private, which should
>  +	 * For mapped eb, we're going to change the folio private, which should
> - 	 * be done under the private_lock.
> + 	 * be done under the i_private_lock.
>   	 */
>   	if (mapped)
> - 		spin_lock(&page->mapping->private_lock);
> + 		spin_lock(&page->mapping->i_private_lock);
>  =20
>  -	if (!PagePrivate(page)) {
>  +	if (!folio_test_private(folio)) {
>   		if (mapped)
> - 			spin_unlock(&page->mapping->private_lock);
> + 			spin_unlock(&page->mapping->i_private_lock);
>   		return;
>   	}
>  =20
> @@@ -3120,11 -3103,14 +3120,11 @@@
>   			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
>   			BUG_ON(PageDirty(page));
>   			BUG_ON(PageWriteback(page));
>  -			/*
>  -			 * We need to make sure we haven't be attached
>  -			 * to a new eb.
>  -			 */
>  -			detach_page_private(page);
>  +			/* We need to make sure we haven't be attached to a new eb. */
>  +			folio_detach_private(folio);
>   		}
>   		if (mapped)
> - 			spin_unlock(&page->mapping->private_lock);
> + 			spin_unlock(&page->mapping->i_private_lock);
>   		return;
>   	}
>  =20
> @@@ -3588,8 -3513,8 +3588,8 @@@ struct extent_buffer *alloc_extent_buff
>   	num_pages =3D num_extent_pages(eb);
>  =20
>   	/*
>  -	 * Preallocate page->private for subpage case, so that we won't
>  +	 * Preallocate folio private for subpage case, so that we won't
> - 	 * allocate memory with private_lock nor page lock hold.
> + 	 * allocate memory with i_private_lock nor page lock hold.
>   	 *
>   	 * The memory will be freed by attach_extent_buffer_page() or freed
>   	 * manually if we exit earlier.
> @@@ -3602,31 -3527,24 +3602,31 @@@
>   		}
>   	}
>  =20
>  -	for (i =3D 0; i < num_pages; i++, index++) {
>  -		p =3D find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
>  -		if (!p) {
>  -			exists =3D ERR_PTR(-ENOMEM);
>  -			btrfs_free_subpage(prealloc);
>  -			goto free_eb;
>  -		}
>  +	/* Allocate all pages first. */
>  +	ret =3D btrfs_alloc_page_array(num_pages, eb->pages, __GFP_NOFAIL);
>  +	if (ret < 0) {
>  +		btrfs_free_subpage(prealloc);
>  +		goto out;
>  +	}
>  =20
>  -		spin_lock(&mapping->i_private_lock);
>  -		exists =3D grab_extent_buffer(fs_info, p);
>  -		if (exists) {
>  -			spin_unlock(&mapping->i_private_lock);
>  -			unlock_page(p);
>  -			put_page(p);
>  -			mark_extent_buffer_accessed(exists, p);
>  -			btrfs_free_subpage(prealloc);
>  -			goto free_eb;
>  +	/* Attach all pages to the filemap. */
>  +	for (int i =3D 0; i < num_pages; i++) {
>  +		struct page *p;
>  +
>  +		ret =3D attach_eb_page_to_filemap(eb, i, &existing_eb);
>  +		if (ret > 0) {
>  +			ASSERT(existing_eb);
>  +			goto out;
>   		}
>  +		attached++;
>  +
>  +		/*
>  +		 * Only after attach_eb_page_to_filemap(), eb->pages[] is
>  +		 * reliable, as we may choose to reuse the existing page cache
>  +		 * and free the allocated page.
>  +		 */
>  +		p =3D eb->pages[i];
> - 		spin_lock(&mapping->private_lock);
> ++		spin_lock(&mapping->i_private_lock);
>   		/* Should not fail, as we have preallocated the memory */
>   		ret =3D attach_extent_buffer_page(eb, p, prealloc);
>   		ASSERT(!ret);
> @@@ -3640,17 -3558,10 +3640,17 @@@
>   		 * Thus needs no special handling in error path.
>   		 */
>   		btrfs_page_inc_eb_refs(fs_info, p);
> - 		spin_unlock(&mapping->private_lock);
> + 		spin_unlock(&mapping->i_private_lock);
>  =20
>   		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
>  -		eb->pages[i] =3D p;
>  +
>  +		/*
>  +		 * Check if the current page is physically contiguous with previous eb
>  +		 * page.
>  +		 */
>  +		if (i && eb->pages[i - 1] + 1 !=3D p)
>  +			page_contig =3D false;
>  +
>   		if (!btrfs_page_test_uptodate(fs_info, p, eb->start, eb->len))
>   			uptodate =3D 0;
>  =20
> @@@ -4713,11 -4560,11 +4713,11 @@@ static int try_release_subpage_extent_b
>   		release_extent_buffer(eb);
>   	}
>   	/*
>  -	 * Finally to check if we have cleared page private, as if we have
>  -	 * released all ebs in the page, the page private should be cleared no=
w.
>  +	 * Finally to check if we have cleared folio private, as if we have
>  +	 * released all ebs in the page, the folio private should be cleared n=
ow.
>   	 */
> - 	spin_lock(&page->mapping->private_lock);
> + 	spin_lock(&page->mapping->i_private_lock);
>  -	if (!PagePrivate(page))
>  +	if (!folio_test_private(page_folio(page)))
>   		ret =3D 1;
>   	else
>   		ret =3D 0;
> @@@ -4735,12 -4581,12 +4735,12 @@@ int try_release_extent_buffer(struct pa
>   		return try_release_subpage_extent_buffer(page);
>  =20
>   	/*
>  -	 * We need to make sure nobody is changing page->private, as we rely on
>  -	 * page->private as the pointer to extent buffer.
>  +	 * We need to make sure nobody is changing folio private, as we rely on
>  +	 * folio private as the pointer to extent buffer.
>   	 */
> - 	spin_lock(&page->mapping->private_lock);
> + 	spin_lock(&page->mapping->i_private_lock);
>  -	if (!PagePrivate(page)) {
>  +	if (!folio_test_private(folio)) {
> - 		spin_unlock(&page->mapping->private_lock);
> + 		spin_unlock(&page->mapping->i_private_lock);
>   		return 1;
>   	}
>  =20

This is now a conflict between the btrfs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/zCjY7qNInrID8O53k+q7+Th
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWcYYoACgkQAVBC80lX
0GwSVwgAgpVJ41AlNkeJ8Dkvww0HmFoLSGRz4ui903kODvLTIowcr8gDEIyZSngF
VgaFCMPuJxcwlVB12cpCvbAtsR96zrNFQrYi9FDFM2WG3fmMSojOhj7WoHT57tOE
Jh7GGmIudNJEsXe1R046RT5W7tO5vYsM8T6ObsYdL0OxkNGPx8A5Yxr49EUslB6O
z99OUBlZyuihMbtXdh5BYLwX8EtRpXZBfx+Gs5LF2AH/e6lqS9v0zPqzr/+PIWHz
8qXjiI4aTPGRAUL1kKJXmy7rlvFM3KHaHaqNI84wE/eIjG6XW9kBJk02ZmUChfH6
O6ui7KoBUr+I4GpnE7f/O/rbKqGsnw==
=kwlC
-----END PGP SIGNATURE-----

--Sig_/zCjY7qNInrID8O53k+q7+Th--

