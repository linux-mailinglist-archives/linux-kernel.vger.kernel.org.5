Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01277BD152
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 01:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345000AbjJHXsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 19:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344978AbjJHXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:48:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E2BA6;
        Sun,  8 Oct 2023 16:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696808922;
        bh=kzxlkgCKTVmkdEEwr6mAU9WSKV8yF3UlDm0Dhxea82A=;
        h=Date:From:To:Cc:Subject:From;
        b=o3Y6sJfVcaUpn+ZIzCoL6jRz1ERVgtI3QSbMCX7aKhvq6cOWhABGEMswUmLAuQguX
         8o5bzLOZCG1Tw1oPW/IHJxZIO71XCmR/VYXq/bEuSJYyQKQNNy+mYbPWWp5nVZXZCb
         G7V5Wry03VG6pR+FD4l66Qmdi2XvZCBNQ+7AUj3zdE17Wv2JV1PxOZ10IvDl84mzyv
         Kayutym5wgYlf6Iag2Eu2l++9LbyZoVChy9tzimd+A8nNrMLXkixMmVqYJyajW+W+6
         dvYOaFdeO6RndASqEvqKhKYCXy1SgUW6ojLcBARHB7ica76s2qy3vgCBYumiuc4Oan
         9tNIIZdieQOHA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3f4n73sfz4x80;
        Mon,  9 Oct 2023 10:48:41 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 10:48:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231009104840.1bdadc80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XEn+ySigath4URUO24BB0s7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XEn+ySigath4URUO24BB0s7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got lots of conflicts
against the btrfs tree.  This is because the vfs-braunter tree has merged
a previous version of the btrfs tree and now the btrfs tree has rebased
and changed several commits.

You cannot merge another tree in linux-next unless the otehr tree is
guaranteed not to rebase (or have commits rewritten in it).

The following commits are duplicates between the two trees (same patch
but different commit) and there are also some that are slightly different
patches:

  00e27794611a ("btrfs: qgroup: use qgroup_iterator to replace tmp ulist in=
 qgroup_update_refcnt()")
  0170b5c5e607 ("btrfs: reduce size of prelim_ref::level")
  01c41e751fcb ("btrfs: call btrfs_close_devices from ->kill_sb")
  025e4dc521e1 ("btrfs: remove refs_to_drop argument from __btrfs_free_exte=
nt()")
  0266c8c65c81 ("btrfs: use a single variable for return value at lookup_in=
line_extent_backref()")
  096833591c4b ("btrfs: qgroup: iterate qgroups without memory allocation f=
or qgroup_reserve()")
  0bd5b51b99fa ("btrfs: always open the device read-only in btrfs_scan_one_=
device")
  0c516db11952 ("btrfs: remove redundant root argument from btrfs_update_in=
ode_item()")
  0c612f9e77cc ("btrfs: stop doing excessive space reservation for csum del=
etion")
  0d9436739af2 ("btrfs: scan but don't register device on single device fil=
esystem")
  0e3380da547b ("btrfs: don't arbitrarily slow down delalloc if we're commi=
tting")
  1172a0c18f3b ("btrfs: remove pointless initialization at btrfs_delayed_re=
fs_rsv_release()")
  1488ae026122 ("btrfs: sysfs: add simple_quota incompat feature entry")
  18030a255de2 ("btrfs: move extent_buffer::lock_owner to debug section")
  1a5bda4c5bac ("btrfs: relocation: use more natural types for tree_block b=
itfields")
  1e4f604b274f ("btrfs: return -EUCLEAN if extent item is missing when sear=
ching inline backref")
  1fbf413f4346 ("btrfs: use a single variable for return value at run_delay=
ed_extent_op()")
  206536cd2851 ("btrfs: reject devices with CHANGING_FSID_V2")
  2263c3dadd27 ("btrfs: remove redundant root argument from btrfs_update_in=
ode()")
  23030f1872bd ("btrfs: map uncontinuous extent buffer pages into virtual a=
ddress space")
  244c627c729d ("btrfs: move btrfs_extref_hash into inode-item.h")
  254cedfd09da ("btrfs: remove stale comment from btrfs_free_extent()")
  256a88a21f59 ("btrfs: mark transaction id check as unlikely at btrfs_mark=
_buffer_dirty()")
  25ec25120282 ("btrfs: zoned: factor out single bg handling from btrfs_loa=
d_block_group_zone_info")
  28a4901d0247 ("btrfs: comment about fsid and metadata_uuid relationship")
  2c5a947f8f7a ("btrfs: tree-checker: add support for raid stripe tree")
  2fe808177f98 ("btrfs: qgroup: use qgroup_iterator in __qgroup_excl_accoun=
ting()")
  37282c19f15b ("btrfs: relocation: switch bitfields to bool in reloc_contr=
ol")
  37adfa983dde ("btrfs: qgroup: use qgroup_iterator in qgroup_convert_meta(=
)")
  39e02b54f663 ("btrfs: qgroup: remove unused helpers for ulist aux data")
  3a2ccead18f6 ("btrfs: check-integrity: remove CONFIG_BTRFS_FS_CHECK_INTEG=
RITY option")
  3cf06838fab9 ("btrfs: remove pointless 'ref_root' variable from run_delay=
ed_data_ref()")
  3dbaabf131ab ("btrfs: sysfs: expose quota mode via sysfs")
  401f89cc5c1e ("btrfs: reduce parameters of btrfs_pin_reserved_extent")
  4146050f0535 ("btrfs: utilize the physically/virtually continuous extent =
buffer memory")
  41dd41a59eef ("btrfs: split btrfs_fs_devices.opened")
  41f394848b0c ("btrfs: qgroup: introduce quota mode")
  44d518b3a2f3 ("btrfs: rename tree_ref and data_ref owning_root")
  44ef1e5b86ea ("btrfs: record simple quota deltas in delayed refs")
  4b58a2dbb970 ("btrfs: add raid stripe tree to features enabled with debug=
 config")
  55f696fe8f18 ("btrfs: track original extent owner in head_ref")
  58d8cff02f7c ("btrfs: relocation: open code mapping_tree_init")
  5d2c6a3f6a5a ("btrfs: track data relocation with simple quota")
  5f5ff8f0d9ce ("btrfs: remove redundant root argument from maybe_insert_ho=
le()")
  6261fa6c858f ("btrfs: reduce size of struct btrfs_ref")
  655df68dc47d ("btrfs: scrub: implement raid stripe tree support")
  667904274890 ("btrfs: qgroup: prealloc btrfs_qgroup_list for __add_relati=
on_rb()")
  686b6a24fc74 ("btrfs: make extent_io_tree_release() more efficient")
  7181df86dc94 ("btrfs: check-integrity: remove btrfsic_unmount() function")
  775b26e4ccaa ("btrfs: remove redundant root argument from btrfs_delayed_u=
pdate_inode()")
  78b5f8cf81a6 ("btrfs: make sure we cache next state in find_first_extent_=
bit()")
  7913ec811cb3 ("btrfs: reformat remaining kdoc style comments")
  7a2841ae12d7 ("btrfs: qgroup: track metadata relocation COW with simple q=
uota")
  7b2f8e075d2b ("btrfs: tracepoints: add events for raid stripe tree")
  7ba59aa76414 ("btrfs: zoned: factor out DUP bg handling from btrfs_load_b=
lock_group_zone_info")
  7d2d132d7377 ("btrfs: qgroup: pre-allocate btrfs_qgroup to reduce GFP_ATO=
MIC usage")
  7e4ea691953d ("btrfs: add btrfs_delayed_ref_head declaration to extent-tr=
ee.h")
  81652d9abb4c ("btrfs: sipmlify uuid parameters of alloc_fs_devices()")
  847de878cd77 ("btrfs: create qgroup earlier in snapshot creation")
  8764e2b05fa2 ("btrfs: update comment for reservation of metadata space fo=
r delayed items")
  88303e09efeb ("btrfs: qgroup: add new quota mode for simple quotas")
  88d6b34c273b ("btrfs: add fscrypt related dependencies to respective head=
ers")
  89a134e82379 ("btrfs: drop __must_check annotations")
  8c4c87fee0cb ("btrfs: initialize key where it's used when running delayed=
 data ref")
  8c8c0668bc06 ("btrfs: remove redundant root argument from btrfs_update_in=
ode_fallback()")
  8dbfbc8212b6 ("btrfs: remove unnecessary logic when running new delayed r=
eferences")
  8f46ee177f9e ("btrfs: qgroup: only set QUOTA_ENABLED when done reading qg=
roups")
  8fccdeee3260 ("btrfs: use btrfs_crit at btrfs_mark_buffer_dirty()")
  90911b16854e ("btrfs: update stale comment at extent_io_tree_release()")
  974ea1e1dced ("btrfs: include linux/iomap.h in file.c")
  9823506bbabc ("btrfs: collapse wait_on_state() to its caller wait_extent_=
bit()")
  99fea7429097 ("btrfs: relocation: use enum for stages")
  9a8264cbc207 ("btrfs: remove refs_to_add argument from __btrfs_inc_extent=
_ref()")
  9af116141f5e ("btrfs: check-integrity: remove btrfsic_check_bio() functio=
n")
  a13fc1494581 ("btrfs: relocation: constify parameters where possible")
  a51d5aa50249 ("btrfs: move btrfs_defrag_root() to defrag.{c,h}")
  a5526bfa5317 ("btrfs: reserve space for delayed refs on a per ref basis")
  aa1cbbaaceb4 ("btrfs: add helper for inline owner ref lookup")
  adcbff903c0a ("btrfs: new inline ref storing owning subvol of data extent=
s")
  ae3c53e03eaf ("btrfs: qgroup: check generation when recording simple quot=
a delta")
  af2851c7e85c ("btrfs: qgroup: use qgroup_iterator in btrfs_qgroup_free_re=
froot()")
  b07a0f7efc15 ("btrfs: pass a space_info argument to btrfs_reserve_metadat=
a_bytes()")
  b10a83023f61 ("btrfs: remove the refcount warning/check at btrfs_put_dela=
yed_ref()")
  b1668d4289b5 ("btrfs: remove pointless loop from btrfs_update_block_group=
()")
  b17b48262238 ("btrfs: include linux/security.h in super.c")
  b464b68ffa11 ("btrfs: simplify check for extent item overrun at lookup_in=
line_extent_backref()")
  b4a664ad7058 ("btrfs: move btrfs_name_hash to dir-item.h")
  ba41e3f24f38 ("btrfs: zoned: introduce a zone_info struct in btrfs_load_b=
lock_group_zone_info")
  ba76f99bc974 ("btrfs: reduce parameters of btrfs_pin_extent_for_log_repla=
y")
  bd07fb48543d ("btrfs: remove useless comment from btrfs_pin_extent_for_lo=
g_replay()")
  bd2397cfa662 ("btrfs: zoned: factor out per-zone logic from btrfs_load_bl=
ock_group_zone_info")
  be4ccd3db6ad ("btrfs: remove redundant root argument from fixup_inode_lin=
k_count()")
  bf7009433d2c ("btrfs: move btrfs_crc32c_final into free-space-cache.c")
  c20943e2cfda ("btrfs: include trace header in where necessary")
  c43c08fdc78e ("btrfs: reduce size and reorder compression members in stru=
ct btrfs_inode")
  c461ca14b76e ("btrfs: remove incomplete metadata_uuid conversion fixup lo=
gic")
  c51cdcd1ba63 ("btrfs: make wait_extent_bit() static")
  c703dc4d72a6 ("btrfs: move functions comments from qgroup.h to qgroup.c")
  d056274031e5 ("btrfs: simplify error check condition at btrfs_dirty_inode=
()")
  d08ef7486357 ("btrfs: do not require EXTENT_NOWAIT for btrfs_redirty_list=
_add()")
  d1432a9acc60 ("btrfs: include asm/unaligned.h in accessors.h")
  d387ae42784d ("btrfs: remove noinline from btrfs_update_inode()")
  d6540ef346d1 ("btrfs: make extent state merges more efficient during inse=
rtions")
  d74100792148 ("btrfs: track owning root in btrfs_ref")
  d8897d7d197e ("btrfs: check-integrity: remove btrfsic_mount() function")
  da64d31c6820 ("btrfs: remove the need_raid_map parameter from btrfs_map_b=
lock()")
  da9b993b494f ("btrfs: add helper for recording simple quota deltas")
  dd20d5749497 ("btrfs: remove btrfs_crc32c wrapper")
  dd3800cf0f2b ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tre=
e")
  dd99b78be273 ("btrfs: open block devices after superblock creation")
  de2aa50f1af4 ("btrfs: abort transaction on generation mismatch when marki=
ng eb as dirty")
  e0a95452557f ("btrfs: read raid stripe tree from disk")
  e52ee3a64a18 ("btrfs: warn on tree blocks which are not nodesize aligned")
  e6aece34f28c ("btrfs: remove pointless memory barrier from extent_io_tree=
_release()")
  e79beb802f47 ("btrfs: qgroup: use qgroup_iterator_nested to in qgroup_upd=
ate_refcnt()")
  e9ff4ac68dd9 ("btrfs: always reserve space for delayed refs when starting=
 transaction")
  ed8c68fb0cad ("btrfs: sysfs: announce presence of raid-stripe-tree")
  f25fab65bfff ("btrfs: qgroup: simple quota auto hierarchy for nested subv=
olumes")
  f359f7ce2037 ("btrfs: relocation: return bool from btrfs_should_ignore_re=
loc_root")
  f4164e6df0d7 ("btrfs: use the super_block as holder when mounting file sy=
stems")
  f47602f7605d ("btrfs: allow to run delayed refs by bytes to be released i=
nstead of count")
  f4e65ababe47 ("btrfs: use extent_io_tree_release() to empty dirty log pag=
es")
  f8fdb685b8d9 ("btrfs: switch btrfs_backref_cache::is_reloc to bool")
  f92547da557f ("btrfs: merge ordered work callbacks in btrfs_work into one=
")
  fa5cf2ac4d06 ("btrfs: reduce arguments of helpers space accounting root i=
tem")
  fdd5252afbc3 ("btrfs: remove extraneous includes from ctree.h")

I have dropped the vfs-brauner tree for today as there is no way I can
sort them out in a reasonable time.  Please sort this out between
yourselves.

--=20
Cheers,
Stephen Rothwell

--Sig_/XEn+ySigath4URUO24BB0s7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjP9gACgkQAVBC80lX
0Gw23wf/QgWo0Dj5SD1zlX35ThlKdWU5QKCRiTUdB5rKQ2o+OfW3hP9pRzqiG33I
WC+ma5b+oCm3kEqeN0QhRX0f+21cyqHU5diOq/cDVJTLDLsevSK6V7fAuKQOU1up
4HBuW7c1UxNh1sm2sGI4uGeUeFTeqTN+kEhVa7I5CJ46m/xwm2dLysU0Uxv5KC/Z
mkBl1vgEslOenQthBazAyX+dN1NNmLChf0rak8e3O5+Rcfx8i6jLXHlySekraqOW
HcX4q4Iv5Ce/R2gJl57Ytd6ukU7XN0ThxgaF8cS0sKADcNtTeS63A0u0FgFoNqAr
1Ics7xke18I7nN1CCP8Zy9sTL9cikg==
=bxtw
-----END PGP SIGNATURE-----

--Sig_/XEn+ySigath4URUO24BB0s7--
