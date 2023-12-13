Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BA811F89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjLMT4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjLMTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:55:23 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40173272E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:54:04 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d226f51f71so71686587b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1702497243; x=1703102043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmWTjWPan/uCKeG+lUoh6N3QXdjfrZKppGzES0K5pPo=;
        b=o/UHibt3StmppY2PYiKbIEHJwrZ3wE349tiUQPVjlwC+cxQTZAw9NVzB8aiOgdDIsn
         PxdvBUZDUSeT3x7nwrrXGVAPXvzYEGCw05kveukwB6owNV/eLYM9Ds8HNImYPR4h/mkr
         yH2yT7wnKME0p/1M+vNmcXdeR+vSlo0gii4zy4E6OArhI1NLZ+hPz24ViY81qrm+9b63
         RJU8PHGtq9r1B2Y+jDAc14Bq6rhY6R/tA3nVbZwxaDuX09aPBwr6gE56LdRVmspZLOV1
         WURmpccs3FirhmNyqt1Du8rlcAD9fxoAUcuaNqJg/3PuF+nPV2JZGcZ6iTr4Pvao7zFq
         GKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497243; x=1703102043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmWTjWPan/uCKeG+lUoh6N3QXdjfrZKppGzES0K5pPo=;
        b=m2PI4qg9IiHUTElZl0RoXxSd2xb95yGhCYB12smMO6JUm7y73kKWGKDkvdsG4HXTdT
         C4k7PYt8fmbXe0MdKBZbiVBM44Rj+88/lilTrxeIhaiXV6Os0xm0FGrr/pY4TT+MNyY/
         hlontANaYYNgBsxmAeGYS8MZnROmuMI2G6IC/025l3SKYrKSAXbG6m/Qy93him4d3JzT
         oiaXczJhxS4TBpIoHRdIn0s2RpImOS7eTMiPDv7VjvQykelYI/6mSsYJfAC7Gymf26YJ
         ShIJ7zF51re+EYI3abbSpuSpkzmXELNOqHMIXW5IWP6nYglUISZ+G9QetQq7uyPQ8EHV
         Jzdg==
X-Gm-Message-State: AOJu0YxwFQ8y5lDnWWmlXnqljfAHsgANIcG2R3nQ2EM35uWklpevI27c
        IMuVMI8ZwAMQ8N2MJpuAtEjo9MmYuVX291Gf2L5S5sAlxsCtcigi
X-Google-Smtp-Source: AGHT+IFR6kqN/5EMmozuAk0AOhpRUbPTqiwMhGx1M8iNqf3+crysjNJQB020um4I6Mx6qr6EkPHpzDhaCXUUOXXm3Oo=
X-Received: by 2002:a5b:b04:0:b0:d9a:5630:5281 with SMTP id
 z4-20020a5b0b04000000b00d9a56305281mr5463515ybp.62.1702497242903; Wed, 13 Dec
 2023 11:54:02 -0800 (PST)
MIME-Version: 1.0
References: <202312091837.cKaPw0Tf-lkp@intel.com> <0487d7cc-b906-4a4a-b284-9c79700b4ede@paulmck-laptop>
 <20231213125358.GB3001@suse.cz> <4c814394-6eab-4aca-96af-43f99fb94c01@paulmck-laptop>
 <20231213155440.GA454379@perftesting> <505dba1e-4950-4968-a789-434c52a3e1c7@paulmck-laptop>
In-Reply-To: <505dba1e-4950-4968-a789-434c52a3e1c7@paulmck-laptop>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 13 Dec 2023 14:53:52 -0500
Message-ID: <CAEzrpqfDjwi4oE19i2s+AZJHd8uxfxKVtnTD0O9VXGYzSYhQsw@mail.gmail.com>
Subject: Re: [paulmck-rcu:frederic.2023.12.08a 29/37] fs/btrfs/transaction.c:496:6:
 error: call to '__compiletime_assert_329' declared with 'error' attribute:
 Need native word sized stores/loads for atomicity.
To:     paulmck@kernel.org
Cc:     David Sterba <dsterba@suse.cz>, kernel test robot <lkp@intel.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, julia.lawall@inria.fr, clm@fb.com,
        dsterba@suse.com, baptiste.lepers@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 1:05=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Dec 13, 2023 at 10:54:40AM -0500, Josef Bacik wrote:
> > On Wed, Dec 13, 2023 at 06:56:37AM -0800, Paul E. McKenney wrote:
> > > On Wed, Dec 13, 2023 at 01:53:58PM +0100, David Sterba wrote:
> > > > On Sat, Dec 09, 2023 at 07:51:30AM -0800, Paul E. McKenney wrote:
> > > > > On Sat, Dec 09, 2023 at 06:20:37PM +0800, kernel test robot wrote=
:
> > > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck=
/linux-rcu.git frederic.2023.12.08a
> > > > > > head:   37843b5f561a08ae899fb791eeeb5abd992eabe2
> > > > > > commit: 7dd87072d40809e26503f04b79d63290288dbbac [29/37] btrfs:=
 Adjust ->last_trans ordering in btrfs_record_root_in_trans()
> > > > > > config: riscv-rv32_defconfig (https://download.01.org/0day-ci/a=
rchive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/config)
> > > > > > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-pr=
oject.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > > > > > reproduce (this is a W=3D1 build): (https://download.01.org/0da=
y-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/reproduce)
> > > > > >
> > > > > > If you fix the issue in a separate patch/commit (i.e. not just =
a new version of
> > > > > > the same patch/commit), kindly add following tags
> > > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312091837.cK=
aPw0Tf-lkp@intel.com/
> > > > > >
> > > > > > All errors (new ones prefixed by >>):
> > > > > >
> > > > > >    warning: unknown warning option '-Wpacked-not-aligned'; did =
you mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
> > > > > >    warning: unknown warning option '-Wstringop-truncation'; did=
 you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
> > > > > >    warning: unknown warning option '-Wmaybe-uninitialized'; did=
 you mean '-Wuninitialized'? [-Wunknown-warning-option]
> > > > > > >> fs/btrfs/transaction.c:496:6: error: call to '__compiletime_=
assert_329' declared with 'error' attribute: Need native word sized stores/=
loads for atomicity.
> > > > > >      496 |         if (smp_load_acquire(&root->last_trans) =3D=
=3D trans->transid && /* ^^^ */
> > > > > >          |             ^
> > > > >
> > > > > Ooooh!!!  :-/
> > > > >
> > > > > From what I can see, the current code can tear this load on 32-bi=
t
> > > > > systems, which can result in bad comparisons and then in failure =
to wait
> > > > > for a partially complete transaction.
> > > > >
> > > > > So is btrfs actually supported on 32-bit systems?  If not, would =
the
> > > > > following patch be appropriate?
> > > >
> > > > There are limitations on 32bit systems, eg. due to shorter inode nu=
mbers
> > > > (ino_t is unsigned long) and that radix-tree/xarray does support on=
ly
> > > > unsigned long keys, while we have 64bit identifiers for inodes or t=
ree
> > > > roots.
> > > >
> > > > So far we support that and dropping it completely is I think a big =
deal,
> > > > like with any possibly used feature. What I've seen there are NAS b=
oxes
> > > > with low power ARM that are 32bit.
> > > >
> > > > > If btrfs is to be supported on 32-bit systems, from what I can se=
e some
> > > > > major surgery is required, even if a 32-bit counter is wrap-safe =
for
> > > > > this particular type of transaction.  (But SSDs?  In-memory btrfs
> > > > > filesystems?)
> > > >
> > > > We won't probably do any major surgery to support 32bit systems.
> > >
> > > Got it, and thank you for the background!  My takeaway is that 32-bit
> > > BTRFS must work in the common case, but might have issues on some
> > > workloads, for example, running out of inode numbers or load tearing.
> > >
> > > > > -----------------------------------------------------------------=
-------
> > > > >
> > > > > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > > > > index 4fb925e8c981..4d56158c34f9 100644
> > > > > --- a/fs/btrfs/Kconfig
> > > > > +++ b/fs/btrfs/Kconfig
> > > > > @@ -19,6 +19,7 @@ config BTRFS_FS
> > > > >         select RAID6_PQ
> > > > >         select XOR_BLOCKS
> > > > >         depends on PAGE_SIZE_LESS_THAN_256KB
> > > > > +       depends on 64BIT
> > > >
> > > > Can we keep the current inefficient smp_* barriers instead of dropp=
ing
> > > > the whole 32bit support as an alternative. If the smp_load_acquire =
are
> > > > better but not strictly necessary for the correctness (from the bar=
riers
> > > > POV) I'd suggest to leave it as-is. We can put comments in case som=
ebody
> > > > wants to optimize it in the future again.
> > >
> > > We still have the barrier placement issue, given that smp_rmb() enfor=
ces
> > > only the ordering of earlier and later loads, correct?  Or am I missi=
ng
> > > some other ordering constraint that makes all that work?
> > >
> > > But I can make each of the current patch's smp_load_acquire() call in=
stead
> > > be be a READ_ONCE() followed by an smp_rmb(), the test_bit_acquire()
> > > call be test_bit() followed by smp_rmb(), and the smp_store_release()
> > > call be an smp_wmb() followed by a WRITE_ONCE().  This provides the n=
eeded
> > > ordering, bullet-proofs the 64-bit code against compilers, but works =
on
> > > 32-bit systems.  For example, on a 32-bit system the 64-bit READ_ONCE=
()
> > > and WRITE_ONCE() might still be compiled as a pair of 32-bit memory
> > > accesses, but they will both be guaranteed to be single memory access=
es
> > > on 64-bit systems.
> > >
> > > Would that work for you guys?
> >
> > Actually I think we just need to re-work all of this to make it less si=
lly.
> > Does this look reasonable to you Paul?  I still have to test it, but I =
think it
> > addresses your concerns and lets us keep 32bit support ;).  Thanks,
>
> Things that avoid the need for memory barriers are often improvements!
>
> I don't claim to understand enough of the BTRFS code to fully judge
> this, but I do ask one stupid question below just in case it inspires
> a non-stupid idea.  ;-)
>

Not a stupid question, I see what you're getting at.  We mix short
term flags and long term flags on ->state.  SHAREABLE in this case is
set at allocation time and never changes, so I'm not worried about
that changing ever.  The only thing here that actually changes is the
RECORDED flag, so just the normal test_bit for that is fine.  Thanks,

Josef
