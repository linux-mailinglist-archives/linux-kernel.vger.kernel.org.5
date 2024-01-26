Return-Path: <linux-kernel+bounces-40781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3A83E591
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BE21F250D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134BC51C25;
	Fri, 26 Jan 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC/B7Nym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107151019;
	Fri, 26 Jan 2024 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308558; cv=none; b=RzxWwi9NHJpoD+z3n8ESq4TT54FRYTbPJUiFTZY0A7/qJuVSFQmBteK6mPpKAsNfhJfVmBOJErl5xoHW04f+P9Az7waP/eSTfmMDikmfdjImOaKSPc8GAbUIPdO4U2NxbYYQn952wNQnHgznPjB63FJo5JS3hrkLMBDgR7D5BTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308558; c=relaxed/simple;
	bh=cpnZy6aqoqEx+3o5SdyKLH4E9s3+M4Sqxz69bryI5vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc0k77pPCnL89PEdY7rA8dU4gbkAYE8UH//1IulBUYAqI2U34VtNibwimUVLDqtMLalyKLdkO64RvdySvi6aoKkfl78AxTb6yTEbGyQ56uKhxKHxGxFsSeU0zFCqdCzvYOD5K78iRQWJSViKYuqzwRa0sl4H93lTUzYUGJCTgVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC/B7Nym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5F2C433C7;
	Fri, 26 Jan 2024 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706308557;
	bh=cpnZy6aqoqEx+3o5SdyKLH4E9s3+M4Sqxz69bryI5vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gC/B7NymVhZAQcUX/xq9XUF5O8zxGf7QP+7nrDYuwk0jAlVPPFIDXcPJEzghWaGhg
	 FHC9PZKWsdwS209m5MSvJy9MgJ83uCDGXmY836wXRp+RvJkfMWUgfmJXs6OpGWpd6M
	 fLqu9ZxLnvsQ0x6cisl1PI9hyv7AoNyGXtRBFUrMRRZxm/ANQ4lofDTfaWq40a+PyR
	 YNyamzJNBYDbmYexT2mLV/9u0fFluiy70U2XS/drfQlIEKiixSWXMLDQfdWqn1hXQM
	 ABYWQ1Pd/9Ca3aW1efd68f1y3RvQu8Gm/NI1yUUAGO6DayXC1rt2lN4E7CFwcfhkYh
	 12SC2bEj1VGOw==
Date: Fri, 26 Jan 2024 15:35:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, llvm@lists.linux.dev,
	keescook@chromium.org, arei.gonglei@huawei.com, mst@redhat.com,
	jasowang@redhat.com, virtualization@lists.linux.dev,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Message-ID: <20240126223554.GA1320833@dev-arch.thelio-3990X>
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
 <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
 <20240126203436.GA913905@dev-arch.thelio-3990X>
 <0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net>

(slimming up the CC list, I don't think this is too relevant to the
wider stable community)

On Fri, Jan 26, 2024 at 01:01:15PM -0800, Guenter Roeck wrote:
> On 1/26/24 12:34, Nathan Chancellor wrote:
> > On Fri, Jan 26, 2024 at 10:17:23AM -0800, Guenter Roeck wrote:
> > > On 1/26/24 09:51, Greg Kroah-Hartman wrote:
> > > > On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
> > > > > On 1/22/24 15:55, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 5.10.209 release.
> > > > > > There are 286 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > > 
> > > > > [ ... ]
> > > > > 
> > > > > > zhenwei pi <pizhenwei@bytedance.com>
> > > > > >        virtio-crypto: implement RSA algorithm
> > > > > > 
> > > > > 
> > > > > Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
> > > > > It is quite beyond a bug fix. Also, unless I am really missing something,
> > > > > the series (or at least this patch) was not applied to v5.15.y, so we now
> > > > > have functionality in v5.10.y which is not in v5.15.y.
> > > > 
> > > > See the commit text, it was a dependency of a later fix and documented
> > > > as such.
> > > > 
> > > > Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
> > > > gladly accepted :)
> > > > 
> > > 
> > > We reverted the entire series from the merge because it results in a build
> > > failure for us.
> > > 
> > > In file included from /home/groeck/src/linux-chromeos/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:10:
> > > In file included from /home/groeck/src/linux-chromeos/include/linux/mpi.h:21:
> > > In file included from /home/groeck/src/linux-chromeos/include/linux/scatterlist.h:5:
> > > In file included from /home/groeck/src/linux-chromeos/include/linux/string.h:293:
> > > /home/groeck/src/linux-chromeos/include/linux/fortify-string.h:512:4: error: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> > >                          __read_overflow2_field(q_size_field, size);
> > 
> > For what it's worth, this is likely self inflicted for chromeos-5.10,
> > which carries a revert of commit eaafc590053b ("fortify: Explicitly
> > disable Clang support") as commit c19861d34c003 ("CHROMIUM: Revert
> > "fortify: Explicitly disable Clang support""). I don't see the series
> > that added proper support for clang to fortify in 5.18 that ended with
> > commit 281d0c962752 ("fortify: Add Clang support") in that ChromeOS
> > branch, so this seems somewhat expected.
> > 
> 
> That explains that ;-). I don't mind if the patches stay in v5.10.y,
> we have them reverted anyway.
> 
> The revert was a pure process issue, as you may see when looking into
> commit c19861d34c003, so, yes, I agree that it is self-inflicted damage.
> Still, that doesn't explain why the problem exists in 5.18+.
> 
> > > I also see that upstream (starting with 6.1) when trying to build it with clang,
> > > so I guess it is one of those bug-for-bug compatibility things. I really have
> > > no idea what causes it, or why we don't see the problem when building
> > > chromeos-6.1 or chromeos-6.6, but (so far) only with chromeos-5.10 after
> > > merging 5.10.209 into it. Making things worse, the problem isn't _always_
> > > seen. Sometimes I can compile the file in 6.1.y without error, sometimes not.
> > > I have no idea what triggers the problem.
> > 
> > Have a .config that reproduces it on upstream? I have not personally
> > seen this warning in my build matrix nor has our continuous-integration
> > matrix (I don't see it in the warning output at the bottom but that
> > could have missed something for some reason) in 6.1:
> > 
> 
> The following command sequence reproduces the problem for me with all stable
> branches starting with 5.18.y (plus mainline).
> 
> rm -rf /tmp/crypto-build
> mkdir /tmp/crypto-build
> make -j CC=clang-15 mrproper >/dev/null 2>&1
> make -j O=/tmp/crypto-build CC=clang-15 allmodconfig >/dev/null 2>&1
> make -j O=/tmp/crypto-build W=1 CC=clang-15 drivers/crypto/virtio/virtio_crypto_akcipher_algs.o
> 
> I tried clang versions 14, 15, and 16. This is with my home system running
> Ubuntu 22.04, no ChromeOS or Google specifics/internals involved. For clang-15,
> the version is
> 
> Ubuntu clang version 15.0.7
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin

Okay interesting, this warning is hidden behind W=1, which our CI does
not test with. Looks like it has been that way since the introduction of
these checks in f68f2ff91512 ("fortify: Detect struct member overflows
in memcpy() at compile-time").

I think this is a legitimate warning though. It is complaining about the
second memcpy() in virtio_crypto_alg_akcipher_init_session():

  memcpy(&ctrl->u, para, sizeof(ctrl->u));

where ctrl is:

  struct virtio_crypto_op_ctrl_req {
          struct virtio_crypto_ctrl_header header;         /*     0    16 */
          union {
                  struct virtio_crypto_sym_create_session_req sym_create_session; /*    16    56 */
                  struct virtio_crypto_hash_create_session_req hash_create_session; /*    16    56 */
                  struct virtio_crypto_mac_create_session_req mac_create_session; /*    16    56 */
                  struct virtio_crypto_aead_create_session_req aead_create_session; /*    16    56 */
                  struct virtio_crypto_akcipher_create_session_req akcipher_create_session; /*    16    56 */
                  struct virtio_crypto_destroy_session_req destroy_session; /*    16    56 */
                  __u8               padding[56];          /*    16    56 */
          } u;                                             /*    16    56 */
          union {
                  struct virtio_crypto_sym_create_session_req sym_create_session; /*     0    56 */
                  struct virtio_crypto_hash_create_session_req hash_create_session; /*     0    56 */
                  struct virtio_crypto_mac_create_session_req mac_create_session; /*     0    56 */
                  struct virtio_crypto_aead_create_session_req aead_create_session; /*     0    56 */
                  struct virtio_crypto_akcipher_create_session_req akcipher_create_session; /*     0    56 */
                  struct virtio_crypto_destroy_session_req destroy_session; /*     0    56 */
                  __u8                       padding[56];          /*     0    56 */
          };


          /* size: 72, cachelines: 2, members: 2 */
          /* last cacheline: 8 bytes */
  };

(so size and p_size_field should be 56) and the type of the para
parameter in virtio_crypto_alg_akcipher_init_session() is 'void *' but
the para passed by reference to
virtio_crypto_alg_akcipher_init_session() in virtio_crypto_rsa_set_key()
has a type of 'struct virtio_crypto_akcipher_session_para':

  struct virtio_crypto_akcipher_session_para {
          __le32                     algo;                 /*     0     4 */
          __le32                     keytype;              /*     4     4 */
          __le32                     keylen;               /*     8     4 */
          union {
                  struct virtio_crypto_rsa_session_para rsa; /*    12     8 */
                  struct virtio_crypto_ecdsa_session_para ecdsa; /*    12     8 */
          } u;                                             /*    12     8 */
          union {
                  struct virtio_crypto_rsa_session_para rsa;       /*     0     8 */
                  struct virtio_crypto_ecdsa_session_para ecdsa;   /*     0     8 */
          };


          /* size: 20, cachelines: 1, members: 4 */
          /* last cacheline: 20 bytes */
  };

(so q_size_field would be 20 if clang were able to do inlining to see
through the 'void *'...?), which would result in the

  __compiletime_lessthan(q_size_field, size)

check succeeding and triggering the warning because 20 < 56, so it does
seem like there is an overread of the source buffer here? Adding the
maintainers of the driver and subsystem in question.

Cheers,
Nathan

