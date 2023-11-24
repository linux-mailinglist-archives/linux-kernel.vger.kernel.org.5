Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4189B7F7685
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjKXOkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjKXOkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:40:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245119A1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700836811; x=1732372811;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qS8TAzADVmVtNewOhjSy2Pf73EzZOFVOFdk96x7B3cw=;
  b=Hbq1g+KeebkNzoEEP2cjHxkYa/QkrxSs9ZRn7dxisUxrdGGbDM84p1lM
   vSgiLdwtq6wuBaUAogpfKQO7F4TP4PDBuRqUzoaPUaxrmlD05ruwARJbd
   yegVpPPmsI2wxtwAqoVgxZ9V5juZWu0YDdWzxHFK5alwkIgitWLUBtZ5d
   XQceMDC1syiGY5Ffy8tZA503eRYJito036R47GINpetHbFRISNoSEInAy
   ns5/x4asVOMjhY1VJ3jnP9gelSy7T44RfQeb0TnF3S8HFfzhmo3GHzj3P
   mS6Y058tgQi3HMCtWvUXqv1nhWoGTZfiIyfvaBQ4AIW1YXFQRg1pvLVuE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="11110366"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="11110366"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 06:40:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="911464612"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="911464612"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2023 06:40:08 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6XLi-0002tj-1J;
        Fri, 24 Nov 2023 14:40:06 +0000
Date:   Fri, 24 Nov 2023 22:39:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: arch/arm64/kernel/patch-scs.c:67:29: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202311241547.VshdwLyK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1a09972a45ae63efbd1587337c4be13b1893330
commit: 3b619e22c4601b444ed2d6a5458271f72625ac89 arm64: implement dynamic shadow call stack for Clang
date:   1 year ago
config: arm64-randconfig-r133-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241547.VshdwLyK-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20231124/202311241547.VshdwLyK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241547.VshdwLyK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/arm64/kernel/patch-scs.c:249:24: sparse: sparse: symbol 'scs_patch_vmlinux' was not declared. Should it be static?
>> arch/arm64/kernel/patch-scs.c:67:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   arch/arm64/kernel/patch-scs.c:67:29: sparse:     expected unsigned int [usertype]
   arch/arm64/kernel/patch-scs.c:67:29: sparse:     got restricted __le32 [usertype]
   arch/arm64/kernel/patch-scs.c:70:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   arch/arm64/kernel/patch-scs.c:70:29: sparse:     expected unsigned int [usertype]
   arch/arm64/kernel/patch-scs.c:70:29: sparse:     got restricted __le32 [usertype]

vim +67 arch/arm64/kernel/patch-scs.c

    60	
    61	static void __always_inline scs_patch_loc(u64 loc)
    62	{
    63		u32 insn = le32_to_cpup((void *)loc);
    64	
    65		switch (insn) {
    66		case PACIASP:
  > 67			*(u32 *)loc = cpu_to_le32(SCS_PUSH);
    68			break;
    69		case AUTIASP:
    70			*(u32 *)loc = cpu_to_le32(SCS_POP);
    71			break;
    72		default:
    73			/*
    74			 * While the DW_CFA_negate_ra_state directive is guaranteed to
    75			 * appear right after a PACIASP/AUTIASP instruction, it may
    76			 * also appear after a DW_CFA_restore_state directive that
    77			 * restores a state that is only partially accurate, and is
    78			 * followed by DW_CFA_negate_ra_state directive to toggle the
    79			 * PAC bit again. So we permit other instructions here, and ignore
    80			 * them.
    81			 */
    82			return;
    83		}
    84		dcache_clean_pou(loc, loc + sizeof(u32));
    85	}
    86	
    87	/*
    88	 * Skip one uleb128/sleb128 encoded quantity from the opcode stream. All bytes
    89	 * except the last one have bit #7 set.
    90	 */
    91	static int __always_inline skip_xleb128(const u8 **opcode, int size)
    92	{
    93		u8 c;
    94	
    95		do {
    96			c = *(*opcode)++;
    97			size--;
    98		} while (c & BIT(7));
    99	
   100		return size;
   101	}
   102	
   103	struct eh_frame {
   104		/*
   105		 * The size of this frame if 0 < size < U32_MAX, 0 terminates the list.
   106		 */
   107		u32	size;
   108	
   109		/*
   110		 * The first frame is a Common Information Entry (CIE) frame, followed
   111		 * by one or more Frame Description Entry (FDE) frames. In the former
   112		 * case, this field is 0, otherwise it is the negated offset relative
   113		 * to the associated CIE frame.
   114		 */
   115		u32	cie_id_or_pointer;
   116	
   117		union {
   118			struct { // CIE
   119				u8	version;
   120				u8	augmentation_string[];
   121			};
   122	
   123			struct { // FDE
   124				s32	initial_loc;
   125				s32	range;
   126				u8	opcodes[];
   127			};
   128		};
   129	};
   130	
   131	static int noinstr scs_handle_fde_frame(const struct eh_frame *frame,
   132						bool fde_has_augmentation_data,
   133						int code_alignment_factor)
   134	{
   135		int size = frame->size - offsetof(struct eh_frame, opcodes) + 4;
   136		u64 loc = (u64)offset_to_ptr(&frame->initial_loc);
   137		const u8 *opcode = frame->opcodes;
   138	
   139		if (fde_has_augmentation_data) {
   140			int l;
   141	
   142			// assume single byte uleb128_t
   143			if (WARN_ON(*opcode & BIT(7)))
   144				return -ENOEXEC;
   145	
   146			l = *opcode++;
   147			opcode += l;
   148			size -= l + 1;
   149		}
   150	
   151		/*
   152		 * Starting from 'loc', apply the CFA opcodes that advance the location
   153		 * pointer, and identify the locations of the PAC instructions.
   154		 */
   155		while (size-- > 0) {
   156			switch (*opcode++) {
   157			case DW_CFA_nop:
   158			case DW_CFA_remember_state:
   159			case DW_CFA_restore_state:
   160				break;
   161	
   162			case DW_CFA_advance_loc1:
   163				loc += *opcode++ * code_alignment_factor;
   164				size--;
   165				break;
   166	
   167			case DW_CFA_advance_loc2:
   168				loc += *opcode++ * code_alignment_factor;
   169				loc += (*opcode++ << 8) * code_alignment_factor;
   170				size -= 2;
   171				break;
   172	
   173			case DW_CFA_def_cfa:
   174			case DW_CFA_offset_extended:
   175				size = skip_xleb128(&opcode, size);
   176				fallthrough;
   177			case DW_CFA_def_cfa_offset:
   178			case DW_CFA_def_cfa_offset_sf:
   179			case DW_CFA_def_cfa_register:
   180			case DW_CFA_same_value:
   181			case DW_CFA_restore_extended:
   182			case 0x80 ... 0xbf:
   183				size = skip_xleb128(&opcode, size);
   184				break;
   185	
   186			case DW_CFA_negate_ra_state:
   187				scs_patch_loc(loc - 4);
   188				break;
   189	
   190			case 0x40 ... 0x7f:
   191				// advance loc
   192				loc += (opcode[-1] & 0x3f) * code_alignment_factor;
   193				break;
   194	
   195			case 0xc0 ... 0xff:
   196				break;
   197	
   198			default:
   199				pr_err("unhandled opcode: %02x in FDE frame %lx\n", opcode[-1], (uintptr_t)frame);
   200				return -ENOEXEC;
   201			}
   202		}
   203		return 0;
   204	}
   205	
   206	int noinstr scs_patch(const u8 eh_frame[], int size)
   207	{
   208		const u8 *p = eh_frame;
   209	
   210		while (size > 4) {
   211			const struct eh_frame *frame = (const void *)p;
   212			bool fde_has_augmentation_data = true;
   213			int code_alignment_factor = 1;
   214			int ret;
   215	
   216			if (frame->size == 0 ||
   217			    frame->size == U32_MAX ||
   218			    frame->size > size)
   219				break;
   220	
   221			if (frame->cie_id_or_pointer == 0) {
   222				const u8 *p = frame->augmentation_string;
   223	
   224				/* a 'z' in the augmentation string must come first */
   225				fde_has_augmentation_data = *p == 'z';
   226	
   227				/*
   228				 * The code alignment factor is a uleb128 encoded field
   229				 * but given that the only sensible values are 1 or 4,
   230				 * there is no point in decoding the whole thing.
   231				 */
   232				p += strlen(p) + 1;
   233				if (!WARN_ON(*p & BIT(7)))
   234					code_alignment_factor = *p;
   235			} else {
   236				ret = scs_handle_fde_frame(frame,
   237							   fde_has_augmentation_data,
   238							   code_alignment_factor);
   239				if (ret)
   240					return ret;
   241			}
   242	
   243			p += sizeof(frame->size) + frame->size;
   244			size -= sizeof(frame->size) + frame->size;
   245		}
   246		return 0;
   247	}
   248	
 > 249	asmlinkage void __init scs_patch_vmlinux(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
