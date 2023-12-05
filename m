Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA9805756
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjLEOaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346745AbjLEOav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:30:51 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEF41A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vWfUl9nY/T5odWyjTGqcK17RhsuAUOQ33CJnFTFSJb8=;
  b=M78TSPsRR+p9Z21lDwiGtCCtJ1RFmYGH4imKZMNPUFrjmTvfYQ39b+Ej
   hUGkzXFamdYev1yg0/plwgj5d6gYuk4dveaQzAh+muZ8By9LyXBKwup/r
   drRUbRTg1rmhfPeABMz/JFapTT6jksPJ9sPb5A1RrDybt8hNYcYpsMrrv
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,252,1695679200"; 
   d="scan'208";a="140416151"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:30:50 +0100
Date:   Tue, 5 Dec 2023 15:30:49 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Jing Zhang <jingzhangos@google.com>
cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, lkp@intel.com
Subject: arch/arm64/kvm/sys_regs.c:2108:5-25: duplicated argument to & or |
 (fwd)
Message-ID: <739ee7-1a2d-1f4f-8997-e9417d7fcd47@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Lines 2108 and 2110 appear to be the same.

julia


---------- Forwarded message ----------
Date: Tue, 5 Dec 2023 22:04:21 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: arch/arm64/kvm/sys_regs.c:2108:5-25: duplicated argument to & or |

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Jing Zhang <jingzhangos@google.com>
CC: Oliver Upton <oliver.upton@linux.dev>
CC: Marc Zyngier <maz@kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: d5a32b60dc184cc7309f83648a368b94d91c797f KVM: arm64: Allow userspace to change ID_AA64MMFR{0-2}_EL1
date:   9 weeks ago
:::::: branch date: 16 hours ago
:::::: commit date: 9 weeks ago
config: arm64-randconfig-r061-20231203 (https://download.01.org/0day-ci/archive/20231205/202312052139.JHPX7I2z-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312052139.JHPX7I2z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312052139.JHPX7I2z-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> arch/arm64/kvm/sys_regs.c:2108:5-25: duplicated argument to & or |

vim +2108 arch/arm64/kvm/sys_regs.c

9da117eec9243f Jintack Lim       2023-02-09  1949
7c8c5e6a9101ea Marc Zyngier      2012-12-10  1950  /*
7c8c5e6a9101ea Marc Zyngier      2012-12-10  1951   * Architected system registers.
7c8c5e6a9101ea Marc Zyngier      2012-12-10  1952   * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
7609c1251f9d8b Marc Zyngier      2014-04-24  1953   *
0c557ed4983b7a Marc Zyngier      2014-04-24  1954   * Debug handling: We do trap most, if not all debug related system
0c557ed4983b7a Marc Zyngier      2014-04-24  1955   * registers. The implementation is good enough to ensure that a guest
0c557ed4983b7a Marc Zyngier      2014-04-24  1956   * can use these with minimal performance degradation. The drawback is
7dabf02f43a167 Oliver Upton      2022-02-03  1957   * that we don't implement any of the external debug architecture.
7dabf02f43a167 Oliver Upton      2022-02-03  1958   * This should be revisited if we ever encounter a more demanding
7dabf02f43a167 Oliver Upton      2022-02-03  1959   * guest...
7c8c5e6a9101ea Marc Zyngier      2012-12-10  1960   */
7c8c5e6a9101ea Marc Zyngier      2012-12-10  1961  static const struct sys_reg_desc sys_reg_descs[] = {
7606e07856e014 Mark Rutland      2017-01-13  1962  	{ SYS_DESC(SYS_DC_ISW), access_dcsw },
d282fa3c5ccb7a Marc Zyngier      2023-05-15  1963  	{ SYS_DESC(SYS_DC_IGSW), access_dcgsw },
d282fa3c5ccb7a Marc Zyngier      2023-05-15  1964  	{ SYS_DESC(SYS_DC_IGDSW), access_dcgsw },
7606e07856e014 Mark Rutland      2017-01-13  1965  	{ SYS_DESC(SYS_DC_CSW), access_dcsw },
d282fa3c5ccb7a Marc Zyngier      2023-05-15  1966  	{ SYS_DESC(SYS_DC_CGSW), access_dcgsw },
d282fa3c5ccb7a Marc Zyngier      2023-05-15  1967  	{ SYS_DESC(SYS_DC_CGDSW), access_dcgsw },
7606e07856e014 Mark Rutland      2017-01-13  1968  	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
d282fa3c5ccb7a Marc Zyngier      2023-05-15  1969  	{ SYS_DESC(SYS_DC_CIGSW), access_dcgsw },
d282fa3c5ccb7a Marc Zyngier      2023-05-15  1970  	{ SYS_DESC(SYS_DC_CIGDSW), access_dcgsw },
7c8c5e6a9101ea Marc Zyngier      2012-12-10  1971
0c557ed4983b7a Marc Zyngier      2014-04-24  1972  	DBG_BCR_BVR_WCR_WVR_EL1(0),
0c557ed4983b7a Marc Zyngier      2014-04-24  1973  	DBG_BCR_BVR_WCR_WVR_EL1(1),
ee1b64e6ccddbd Mark Rutland      2017-01-13  1974  	{ SYS_DESC(SYS_MDCCINT_EL1), trap_debug_regs, reset_val, MDCCINT_EL1, 0 },
ee1b64e6ccddbd Mark Rutland      2017-01-13  1975  	{ SYS_DESC(SYS_MDSCR_EL1), trap_debug_regs, reset_val, MDSCR_EL1, 0 },
0c557ed4983b7a Marc Zyngier      2014-04-24  1976  	DBG_BCR_BVR_WCR_WVR_EL1(2),
0c557ed4983b7a Marc Zyngier      2014-04-24  1977  	DBG_BCR_BVR_WCR_WVR_EL1(3),
0c557ed4983b7a Marc Zyngier      2014-04-24  1978  	DBG_BCR_BVR_WCR_WVR_EL1(4),
0c557ed4983b7a Marc Zyngier      2014-04-24  1979  	DBG_BCR_BVR_WCR_WVR_EL1(5),
0c557ed4983b7a Marc Zyngier      2014-04-24  1980  	DBG_BCR_BVR_WCR_WVR_EL1(6),
0c557ed4983b7a Marc Zyngier      2014-04-24  1981  	DBG_BCR_BVR_WCR_WVR_EL1(7),
0c557ed4983b7a Marc Zyngier      2014-04-24  1982  	DBG_BCR_BVR_WCR_WVR_EL1(8),
0c557ed4983b7a Marc Zyngier      2014-04-24  1983  	DBG_BCR_BVR_WCR_WVR_EL1(9),
0c557ed4983b7a Marc Zyngier      2014-04-24  1984  	DBG_BCR_BVR_WCR_WVR_EL1(10),
0c557ed4983b7a Marc Zyngier      2014-04-24  1985  	DBG_BCR_BVR_WCR_WVR_EL1(11),
0c557ed4983b7a Marc Zyngier      2014-04-24  1986  	DBG_BCR_BVR_WCR_WVR_EL1(12),
0c557ed4983b7a Marc Zyngier      2014-04-24  1987  	DBG_BCR_BVR_WCR_WVR_EL1(13),
0c557ed4983b7a Marc Zyngier      2014-04-24  1988  	DBG_BCR_BVR_WCR_WVR_EL1(14),
0c557ed4983b7a Marc Zyngier      2014-04-24  1989  	DBG_BCR_BVR_WCR_WVR_EL1(15),
0c557ed4983b7a Marc Zyngier      2014-04-24  1990
ee1b64e6ccddbd Mark Rutland      2017-01-13  1991  	{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
f24adc65c5568a Oliver Upton      2022-02-03  1992  	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
d42e26716d038d Oliver Upton      2022-02-03  1993  	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_val, OSLSR_EL1,
187de7c2aad86c Mark Brown        2023-05-23  1994  		OSLSR_EL1_OSLM_IMPLEMENTED, .set_user = set_oslsr_el1, },
ee1b64e6ccddbd Mark Rutland      2017-01-13  1995  	{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
ee1b64e6ccddbd Mark Rutland      2017-01-13  1996  	{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
ee1b64e6ccddbd Mark Rutland      2017-01-13  1997  	{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },
ee1b64e6ccddbd Mark Rutland      2017-01-13  1998  	{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
ee1b64e6ccddbd Mark Rutland      2017-01-13  1999  	{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
ee1b64e6ccddbd Mark Rutland      2017-01-13  2000
ee1b64e6ccddbd Mark Rutland      2017-01-13  2001  	{ SYS_DESC(SYS_MDCCSR_EL0), trap_raz_wi },
ee1b64e6ccddbd Mark Rutland      2017-01-13  2002  	{ SYS_DESC(SYS_DBGDTR_EL0), trap_raz_wi },
ee1b64e6ccddbd Mark Rutland      2017-01-13  2003  	// DBGDTR[TR]X_EL0 share the same encoding
ee1b64e6ccddbd Mark Rutland      2017-01-13  2004  	{ SYS_DESC(SYS_DBGDTRTX_EL0), trap_raz_wi },
ee1b64e6ccddbd Mark Rutland      2017-01-13  2005
ee1b64e6ccddbd Mark Rutland      2017-01-13  2006  	{ SYS_DESC(SYS_DBGVCR32_EL2), NULL, reset_val, DBGVCR32_EL2, 0 },
62a89c44954f09 Marc Zyngier      2013-02-07  2007
851050a573e1d2 Mark Rutland      2017-01-19  2008  	{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
93390c0a1b20b9 Dave Martin       2017-10-31  2009
93390c0a1b20b9 Dave Martin       2017-10-31  2010  	/*
93390c0a1b20b9 Dave Martin       2017-10-31  2011  	 * ID regs: all ID_SANITISED() entries here must have corresponding
93390c0a1b20b9 Dave Martin       2017-10-31  2012  	 * entries in arm64_ftr_regs[].
93390c0a1b20b9 Dave Martin       2017-10-31  2013  	 */
93390c0a1b20b9 Dave Martin       2017-10-31  2014
93390c0a1b20b9 Dave Martin       2017-10-31  2015  	/* AArch64 mappings of the AArch32 ID registers */
93390c0a1b20b9 Dave Martin       2017-10-31  2016  	/* CRm=1 */
d5efec7ed826b3 Oliver Upton      2022-09-13  2017  	AA32_ID_SANITISED(ID_PFR0_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2018  	AA32_ID_SANITISED(ID_PFR1_EL1),
c118cead07a762 Jing Zhang        2023-06-09  2019  	{ SYS_DESC(SYS_ID_DFR0_EL1),
c118cead07a762 Jing Zhang        2023-06-09  2020  	  .access = access_id_reg,
c118cead07a762 Jing Zhang        2023-06-09  2021  	  .get_user = get_id_reg,
c118cead07a762 Jing Zhang        2023-06-09  2022  	  .set_user = set_id_dfr0_el1,
c118cead07a762 Jing Zhang        2023-06-09  2023  	  .visibility = aa32_id_visibility,
c118cead07a762 Jing Zhang        2023-06-09  2024  	  .reset = read_sanitised_id_dfr0_el1,
9f9917bc71b083 Oliver Upton      2023-10-03  2025  	  .val = ID_DFR0_EL1_PerfMon_MASK |
9f9917bc71b083 Oliver Upton      2023-10-03  2026  		 ID_DFR0_EL1_CopDbg_MASK, },
93390c0a1b20b9 Dave Martin       2017-10-31  2027  	ID_HIDDEN(ID_AFR0_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2028  	AA32_ID_SANITISED(ID_MMFR0_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2029  	AA32_ID_SANITISED(ID_MMFR1_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2030  	AA32_ID_SANITISED(ID_MMFR2_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2031  	AA32_ID_SANITISED(ID_MMFR3_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2032
93390c0a1b20b9 Dave Martin       2017-10-31  2033  	/* CRm=2 */
d5efec7ed826b3 Oliver Upton      2022-09-13  2034  	AA32_ID_SANITISED(ID_ISAR0_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2035  	AA32_ID_SANITISED(ID_ISAR1_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2036  	AA32_ID_SANITISED(ID_ISAR2_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2037  	AA32_ID_SANITISED(ID_ISAR3_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2038  	AA32_ID_SANITISED(ID_ISAR4_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2039  	AA32_ID_SANITISED(ID_ISAR5_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2040  	AA32_ID_SANITISED(ID_MMFR4_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2041  	AA32_ID_SANITISED(ID_ISAR6_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2042
93390c0a1b20b9 Dave Martin       2017-10-31  2043  	/* CRm=3 */
d5efec7ed826b3 Oliver Upton      2022-09-13  2044  	AA32_ID_SANITISED(MVFR0_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2045  	AA32_ID_SANITISED(MVFR1_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2046  	AA32_ID_SANITISED(MVFR2_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2047  	ID_UNALLOCATED(3,3),
d5efec7ed826b3 Oliver Upton      2022-09-13  2048  	AA32_ID_SANITISED(ID_PFR2_EL1),
dd35ec07045753 Anshuman Khandual 2020-05-19  2049  	ID_HIDDEN(ID_DFR1_EL1),
d5efec7ed826b3 Oliver Upton      2022-09-13  2050  	AA32_ID_SANITISED(ID_MMFR5_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2051  	ID_UNALLOCATED(3,7),
93390c0a1b20b9 Dave Martin       2017-10-31  2052
93390c0a1b20b9 Dave Martin       2017-10-31  2053  	/* AArch64 ID registers */
93390c0a1b20b9 Dave Martin       2017-10-31  2054  	/* CRm=4 */
c39f5974d38f72 Jing Zhang        2023-06-09  2055  	{ SYS_DESC(SYS_ID_AA64PFR0_EL1),
c39f5974d38f72 Jing Zhang        2023-06-09  2056  	  .access = access_id_reg,
c39f5974d38f72 Jing Zhang        2023-06-09  2057  	  .get_user = get_id_reg,
686672407e6eaf Oliver Upton      2023-06-09  2058  	  .set_user = set_id_reg,
c39f5974d38f72 Jing Zhang        2023-06-09  2059  	  .reset = read_sanitised_id_aa64pfr0_el1,
c39f5974d38f72 Jing Zhang        2023-06-09  2060  	  .val = ID_AA64PFR0_EL1_CSV2_MASK | ID_AA64PFR0_EL1_CSV3_MASK, },
93390c0a1b20b9 Dave Martin       2017-10-31  2061  	ID_SANITISED(ID_AA64PFR1_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2062  	ID_UNALLOCATED(4,2),
93390c0a1b20b9 Dave Martin       2017-10-31  2063  	ID_UNALLOCATED(4,3),
c512298eed0360 Andrew Jones      2020-11-05  2064  	ID_SANITISED(ID_AA64ZFR0_EL1),
90807748ca3ac4 Mark Brown        2022-04-19  2065  	ID_HIDDEN(ID_AA64SMFR0_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2066  	ID_UNALLOCATED(4,6),
93390c0a1b20b9 Dave Martin       2017-10-31  2067  	ID_UNALLOCATED(4,7),
93390c0a1b20b9 Dave Martin       2017-10-31  2068
93390c0a1b20b9 Dave Martin       2017-10-31  2069  	/* CRm=5 */
c118cead07a762 Jing Zhang        2023-06-09  2070  	{ SYS_DESC(SYS_ID_AA64DFR0_EL1),
c118cead07a762 Jing Zhang        2023-06-09  2071  	  .access = access_id_reg,
c118cead07a762 Jing Zhang        2023-06-09  2072  	  .get_user = get_id_reg,
c118cead07a762 Jing Zhang        2023-06-09  2073  	  .set_user = set_id_aa64dfr0_el1,
c118cead07a762 Jing Zhang        2023-06-09  2074  	  .reset = read_sanitised_id_aa64dfr0_el1,
9f9917bc71b083 Oliver Upton      2023-10-03  2075  	  .val = ID_AA64DFR0_EL1_PMUVer_MASK |
9f9917bc71b083 Oliver Upton      2023-10-03  2076  		 ID_AA64DFR0_EL1_DebugVer_MASK, },
93390c0a1b20b9 Dave Martin       2017-10-31  2077  	ID_SANITISED(ID_AA64DFR1_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2078  	ID_UNALLOCATED(5,2),
93390c0a1b20b9 Dave Martin       2017-10-31  2079  	ID_UNALLOCATED(5,3),
93390c0a1b20b9 Dave Martin       2017-10-31  2080  	ID_HIDDEN(ID_AA64AFR0_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2081  	ID_HIDDEN(ID_AA64AFR1_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2082  	ID_UNALLOCATED(5,6),
93390c0a1b20b9 Dave Martin       2017-10-31  2083  	ID_UNALLOCATED(5,7),
93390c0a1b20b9 Dave Martin       2017-10-31  2084
93390c0a1b20b9 Dave Martin       2017-10-31  2085  	/* CRm=6 */
56d77aa8bdf527 Oliver Upton      2023-10-03  2086  	ID_WRITABLE(ID_AA64ISAR0_EL1, ~ID_AA64ISAR0_EL1_RES0),
56d77aa8bdf527 Oliver Upton      2023-10-03  2087  	ID_WRITABLE(ID_AA64ISAR1_EL1, ~(ID_AA64ISAR1_EL1_GPI |
56d77aa8bdf527 Oliver Upton      2023-10-03  2088  					ID_AA64ISAR1_EL1_GPA |
56d77aa8bdf527 Oliver Upton      2023-10-03  2089  					ID_AA64ISAR1_EL1_API |
56d77aa8bdf527 Oliver Upton      2023-10-03  2090  					ID_AA64ISAR1_EL1_APA)),
56d77aa8bdf527 Oliver Upton      2023-10-03  2091  	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
56d77aa8bdf527 Oliver Upton      2023-10-03  2092  					ID_AA64ISAR2_EL1_MOPS |
56d77aa8bdf527 Oliver Upton      2023-10-03  2093  					ID_AA64ISAR2_EL1_APA3 |
56d77aa8bdf527 Oliver Upton      2023-10-03  2094  					ID_AA64ISAR2_EL1_GPA3)),
93390c0a1b20b9 Dave Martin       2017-10-31  2095  	ID_UNALLOCATED(6,3),
93390c0a1b20b9 Dave Martin       2017-10-31  2096  	ID_UNALLOCATED(6,4),
93390c0a1b20b9 Dave Martin       2017-10-31  2097  	ID_UNALLOCATED(6,5),
93390c0a1b20b9 Dave Martin       2017-10-31  2098  	ID_UNALLOCATED(6,6),
93390c0a1b20b9 Dave Martin       2017-10-31  2099  	ID_UNALLOCATED(6,7),
93390c0a1b20b9 Dave Martin       2017-10-31  2100
93390c0a1b20b9 Dave Martin       2017-10-31  2101  	/* CRm=7 */
d5a32b60dc184c Jing Zhang        2023-10-03  2102  	ID_WRITABLE(ID_AA64MMFR0_EL1, ~(ID_AA64MMFR0_EL1_RES0 |
d5a32b60dc184c Jing Zhang        2023-10-03  2103  					ID_AA64MMFR0_EL1_TGRAN4_2 |
d5a32b60dc184c Jing Zhang        2023-10-03  2104  					ID_AA64MMFR0_EL1_TGRAN64_2 |
d5a32b60dc184c Jing Zhang        2023-10-03  2105  					ID_AA64MMFR0_EL1_TGRAN16_2)),
d5a32b60dc184c Jing Zhang        2023-10-03  2106  	ID_WRITABLE(ID_AA64MMFR1_EL1, ~(ID_AA64MMFR1_EL1_RES0 |
d5a32b60dc184c Jing Zhang        2023-10-03  2107  					ID_AA64MMFR1_EL1_HCX |
d5a32b60dc184c Jing Zhang        2023-10-03 @2108  					ID_AA64MMFR1_EL1_XNX |
d5a32b60dc184c Jing Zhang        2023-10-03  2109  					ID_AA64MMFR1_EL1_TWED |
d5a32b60dc184c Jing Zhang        2023-10-03  2110  					ID_AA64MMFR1_EL1_XNX |
d5a32b60dc184c Jing Zhang        2023-10-03  2111  					ID_AA64MMFR1_EL1_VH |
d5a32b60dc184c Jing Zhang        2023-10-03  2112  					ID_AA64MMFR1_EL1_VMIDBits)),
d5a32b60dc184c Jing Zhang        2023-10-03  2113  	ID_WRITABLE(ID_AA64MMFR2_EL1, ~(ID_AA64MMFR2_EL1_RES0 |
d5a32b60dc184c Jing Zhang        2023-10-03  2114  					ID_AA64MMFR2_EL1_EVT |
d5a32b60dc184c Jing Zhang        2023-10-03  2115  					ID_AA64MMFR2_EL1_FWB |
d5a32b60dc184c Jing Zhang        2023-10-03  2116  					ID_AA64MMFR2_EL1_IDS |
d5a32b60dc184c Jing Zhang        2023-10-03  2117  					ID_AA64MMFR2_EL1_NV |
d5a32b60dc184c Jing Zhang        2023-10-03  2118  					ID_AA64MMFR2_EL1_CCIDX)),
8ef67c67e63780 Joey Gouly        2023-06-06  2119  	ID_SANITISED(ID_AA64MMFR3_EL1),
93390c0a1b20b9 Dave Martin       2017-10-31  2120  	ID_UNALLOCATED(7,4),
93390c0a1b20b9 Dave Martin       2017-10-31  2121  	ID_UNALLOCATED(7,5),
93390c0a1b20b9 Dave Martin       2017-10-31  2122  	ID_UNALLOCATED(7,6),
93390c0a1b20b9 Dave Martin       2017-10-31  2123  	ID_UNALLOCATED(7,7),
93390c0a1b20b9 Dave Martin       2017-10-31  2124
851050a573e1d2 Mark Rutland      2017-01-19  2125  	{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
af4738290d9dfe James Morse       2020-06-22  2126  	{ SYS_DESC(SYS_ACTLR_EL1), access_actlr, reset_actlr, ACTLR_EL1 },
851050a573e1d2 Mark Rutland      2017-01-19  2127  	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
2ac638fc5724f0 Catalin Marinas   2020-08-26  2128
e1f358b5046479 Steven Price      2021-06-21  2129  	MTE_REG(RGSR_EL1),
e1f358b5046479 Steven Price      2021-06-21  2130  	MTE_REG(GCR_EL1),
2ac638fc5724f0 Catalin Marinas   2020-08-26  2131
73433762fcaeb9 Dave Martin       2018-09-28  2132  	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
cc427cbb15375f Suzuki K Poulose  2021-04-05  2133  	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
90807748ca3ac4 Mark Brown        2022-04-19  2134  	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
90807748ca3ac4 Mark Brown        2022-04-19  2135  	{ SYS_DESC(SYS_SMCR_EL1), undef_access },
851050a573e1d2 Mark Rutland      2017-01-19  2136  	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
851050a573e1d2 Mark Rutland      2017-01-19  2137  	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
851050a573e1d2 Mark Rutland      2017-01-19  2138  	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
fbff560682323d Joey Gouly        2023-06-06  2139  	{ SYS_DESC(SYS_TCR2_EL1), access_vm_reg, reset_val, TCR2_EL1, 0 },
851050a573e1d2 Mark Rutland      2017-01-19  2140
384b40caa8afae Mark Rutland      2019-04-23  2141  	PTRAUTH_KEY(APIA),
384b40caa8afae Mark Rutland      2019-04-23  2142  	PTRAUTH_KEY(APIB),
384b40caa8afae Mark Rutland      2019-04-23  2143  	PTRAUTH_KEY(APDA),
384b40caa8afae Mark Rutland      2019-04-23  2144  	PTRAUTH_KEY(APDB),
384b40caa8afae Mark Rutland      2019-04-23  2145  	PTRAUTH_KEY(APGA),
384b40caa8afae Mark Rutland      2019-04-23  2146
9da117eec9243f Jintack Lim       2023-02-09  2147  	{ SYS_DESC(SYS_SPSR_EL1), access_spsr},
9da117eec9243f Jintack Lim       2023-02-09  2148  	{ SYS_DESC(SYS_ELR_EL1), access_elr},
9da117eec9243f Jintack Lim       2023-02-09  2149
851050a573e1d2 Mark Rutland      2017-01-19  2150  	{ SYS_DESC(SYS_AFSR0_EL1), access_vm_reg, reset_unknown, AFSR0_EL1 },
851050a573e1d2 Mark Rutland      2017-01-19  2151  	{ SYS_DESC(SYS_AFSR1_EL1), access_vm_reg, reset_unknown, AFSR1_EL1 },
851050a573e1d2 Mark Rutland      2017-01-19  2152  	{ SYS_DESC(SYS_ESR_EL1), access_vm_reg, reset_unknown, ESR_EL1 },
558daf693e0c7e Dongjiu Geng      2018-01-15  2153
558daf693e0c7e Dongjiu Geng      2018-01-15  2154  	{ SYS_DESC(SYS_ERRIDR_EL1), trap_raz_wi },
558daf693e0c7e Dongjiu Geng      2018-01-15  2155  	{ SYS_DESC(SYS_ERRSELR_EL1), trap_raz_wi },
558daf693e0c7e Dongjiu Geng      2018-01-15  2156  	{ SYS_DESC(SYS_ERXFR_EL1), trap_raz_wi },
558daf693e0c7e Dongjiu Geng      2018-01-15  2157  	{ SYS_DESC(SYS_ERXCTLR_EL1), trap_raz_wi },
558daf693e0c7e Dongjiu Geng      2018-01-15  2158  	{ SYS_DESC(SYS_ERXSTATUS_EL1), trap_raz_wi },
558daf693e0c7e Dongjiu Geng      2018-01-15  2159  	{ SYS_DESC(SYS_ERXADDR_EL1), trap_raz_wi },
558daf693e0c7e Dongjiu Geng      2018-01-15  2160  	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
558daf693e0c7e Dongjiu Geng      2018-01-15  2161  	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
558daf693e0c7e Dongjiu Geng      2018-01-15  2162
e1f358b5046479 Steven Price      2021-06-21  2163  	MTE_REG(TFSR_EL1),
e1f358b5046479 Steven Price      2021-06-21  2164  	MTE_REG(TFSRE0_EL1),
2ac638fc5724f0 Catalin Marinas   2020-08-26  2165
851050a573e1d2 Mark Rutland      2017-01-19  2166  	{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
851050a573e1d2 Mark Rutland      2017-01-19  2167  	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
7c8c5e6a9101ea Marc Zyngier      2012-12-10  2168
13611bc80d3da1 Alexandru Elisei  2021-04-09  2169  	{ SYS_DESC(SYS_PMSCR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2170  	{ SYS_DESC(SYS_PMSNEVFR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2171  	{ SYS_DESC(SYS_PMSICR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2172  	{ SYS_DESC(SYS_PMSIRR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2173  	{ SYS_DESC(SYS_PMSFCR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2174  	{ SYS_DESC(SYS_PMSEVFR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2175  	{ SYS_DESC(SYS_PMSLATFR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2176  	{ SYS_DESC(SYS_PMSIDR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2177  	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2178  	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2179  	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
13611bc80d3da1 Alexandru Elisei  2021-04-09  2180  	/* PMBIDR_EL1 is not trapped */
13611bc80d3da1 Alexandru Elisei  2021-04-09  2181
9d2a55b403eea2 Xiang Chen        2023-07-14  2182  	{ PMU_SYS_REG(PMINTENSET_EL1),
11663111cd49b4 Marc Zyngier      2021-01-06  2183  	  .access = access_pminten, .reg = PMINTENSET_EL1 },
9d2a55b403eea2 Xiang Chen        2023-07-14  2184  	{ PMU_SYS_REG(PMINTENCLR_EL1),
11663111cd49b4 Marc Zyngier      2021-01-06  2185  	  .access = access_pminten, .reg = PMINTENSET_EL1 },
46081078feb451 Marc Zyngier      2020-02-16  2186  	{ SYS_DESC(SYS_PMMIR_EL1), trap_raz_wi },
7c8c5e6a9101ea Marc Zyngier      2012-12-10  2187
851050a573e1d2 Mark Rutland      2017-01-19  2188  	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
86f9de9db1783b Joey Gouly        2023-06-06  2189  	{ SYS_DESC(SYS_PIRE0_EL1), access_vm_reg, reset_unknown, PIRE0_EL1 },
86f9de9db1783b Joey Gouly        2023-06-06  2190  	{ SYS_DESC(SYS_PIR_EL1), access_vm_reg, reset_unknown, PIR_EL1 },
851050a573e1d2 Mark Rutland      2017-01-19  2191  	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
7c8c5e6a9101ea Marc Zyngier      2012-12-10  2192
2292552102b059 Marc Zyngier      2018-11-05  2193  	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
2292552102b059 Marc Zyngier      2018-11-05  2194  	{ SYS_DESC(SYS_LOREA_EL1), trap_loregion },
2292552102b059 Marc Zyngier      2018-11-05  2195  	{ SYS_DESC(SYS_LORN_EL1), trap_loregion },
2292552102b059 Marc Zyngier      2018-11-05  2196  	{ SYS_DESC(SYS_LORC_EL1), trap_loregion },
2292552102b059 Marc Zyngier      2018-11-05  2197  	{ SYS_DESC(SYS_LORID_EL1), trap_loregion },
cc33c4e20185a3 Mark Rutland      2018-02-13  2198
9da117eec9243f Jintack Lim       2023-02-09  2199  	{ SYS_DESC(SYS_VBAR_EL1), access_rw, reset_val, VBAR_EL1, 0 },
c773ae2b34760a James Morse       2018-01-15  2200  	{ SYS_DESC(SYS_DISR_EL1), NULL, reset_val, DISR_EL1, 0 },
db7dedd0de714a Christoffer Dall  2014-11-19  2201
7b1dba1f732562 Marc Zyngier      2017-06-09  2202  	{ SYS_DESC(SYS_ICC_IAR0_EL1), write_to_read_only },
e7f1d1eef48215 Marc Zyngier      2017-06-09  2203  	{ SYS_DESC(SYS_ICC_EOIR0_EL1), read_from_write_only },
7b1dba1f732562 Marc Zyngier      2017-06-09  2204  	{ SYS_DESC(SYS_ICC_HPPIR0_EL1), write_to_read_only },
e7f1d1eef48215 Marc Zyngier      2017-06-09  2205  	{ SYS_DESC(SYS_ICC_DIR_EL1), read_from_write_only },
7b1dba1f732562 Marc Zyngier      2017-06-09  2206  	{ SYS_DESC(SYS_ICC_RPR_EL1), write_to_read_only },
e804d208979db6 Mark Rutland      2017-01-20  2207  	{ SYS_DESC(SYS_ICC_SGI1R_EL1), access_gic_sgi },
03bd646d863d1e Marc Zyngier      2018-08-06  2208  	{ SYS_DESC(SYS_ICC_ASGI1R_EL1), access_gic_sgi },
03bd646d863d1e Marc Zyngier      2018-08-06  2209  	{ SYS_DESC(SYS_ICC_SGI0R_EL1), access_gic_sgi },
7b1dba1f732562 Marc Zyngier      2017-06-09  2210  	{ SYS_DESC(SYS_ICC_IAR1_EL1), write_to_read_only },
e7f1d1eef48215 Marc Zyngier      2017-06-09  2211  	{ SYS_DESC(SYS_ICC_EOIR1_EL1), read_from_write_only },
7b1dba1f732562 Marc Zyngier      2017-06-09  2212  	{ SYS_DESC(SYS_ICC_HPPIR1_EL1), write_to_read_only },
e804d208979db6 Mark Rutland      2017-01-20  2213  	{ SYS_DESC(SYS_ICC_SRE_EL1), access_gic_sre },
db7dedd0de714a Christoffer Dall  2014-11-19  2214
851050a573e1d2 Mark Rutland      2017-01-19  2215  	{ SYS_DESC(SYS_CONTEXTIDR_EL1), access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
851050a573e1d2 Mark Rutland      2017-01-19  2216  	{ SYS_DESC(SYS_TPIDR_EL1), NULL, reset_unknown, TPIDR_EL1 },
7c8c5e6a9101ea Marc Zyngier      2012-12-10  2217
484f86824a3d94 Marc Zyngier      2023-08-15  2218  	{ SYS_DESC(SYS_ACCDATA_EL1), undef_access },
484f86824a3d94 Marc Zyngier      2023-08-15  2219
ed4ffaf49bf9ce Marc Zyngier      2020-11-10  2220  	{ SYS_DESC(SYS_SCXTNUM_EL1), undef_access },
ed4ffaf49bf9ce Marc Zyngier      2020-11-10  2221
851050a573e1d2 Mark Rutland      2017-01-19  2222  	{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
7c8c5e6a9101ea Marc Zyngier      2012-12-10  2223
f7f2b15c3d42fa Ard Biesheuvel    2019-01-31  2224  	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
7af0c2534f4c57 Akihiko Odaki     2023-01-12  2225  	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
7af0c2534f4c57 Akihiko Odaki     2023-01-12  2226  	  .set_user = set_clidr },
bf48040cd9b0c4 Akihiko Odaki     2023-01-12  2227  	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
90807748ca3ac4 Mark Brown        2022-04-19  2228  	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
f7f2b15c3d42fa Ard Biesheuvel    2019-01-31  2229  	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
f7f2b15c3d42fa Ard Biesheuvel    2019-01-31  2230  	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
ec0067a63e5a37 Mark Brown        2022-05-10  2231  	{ SYS_DESC(SYS_SVCR), undef_access },
7c8c5e6a9101ea Marc Zyngier      2012-12-10  2232
9d2a55b403eea2 Xiang Chen        2023-07-14  2233  	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr,
11663111cd49b4 Marc Zyngier      2021-01-06  2234  	  .reset = reset_pmcr, .reg = PMCR_EL0 },
9d2a55b403eea2 Xiang Chen        2023-07-14  2235  	{ PMU_SYS_REG(PMCNTENSET_EL0),
11663111cd49b4 Marc Zyngier      2021-01-06  2236  	  .access = access_pmcnten, .reg = PMCNTENSET_EL0 },
9d2a55b403eea2 Xiang Chen        2023-07-14  2237  	{ PMU_SYS_REG(PMCNTENCLR_EL0),
11663111cd49b4 Marc Zyngier      2021-01-06  2238  	  .access = access_pmcnten, .reg = PMCNTENSET_EL0 },
9d2a55b403eea2 Xiang Chen        2023-07-14  2239  	{ PMU_SYS_REG(PMOVSCLR_EL0),
11663111cd49b4 Marc Zyngier      2021-01-06  2240  	  .access = access_pmovs, .reg = PMOVSSET_EL0 },
7a3ba3095a32f9 Marc Zyngier      2021-07-19  2241  	/*
7a3ba3095a32f9 Marc Zyngier      2021-07-19  2242  	 * PM_SWINC_EL0 is exposed to userspace as RAZ/WI, as it was
7a3ba3095a32f9 Marc Zyngier      2021-07-19  2243  	 * previously (and pointlessly) advertised in the past...
7a3ba3095a32f9 Marc Zyngier      2021-07-19  2244  	 */
9d2a55b403eea2 Xiang Chen        2023-07-14  2245  	{ PMU_SYS_REG(PMSWINC_EL0),
5a4309762356f0 Alexandru Elisei  2021-10-11  2246  	  .get_user = get_raz_reg, .set_user = set_wi_reg,
7a3ba3095a32f9 Marc Zyngier      2021-07-19  2247  	  .access = access_pmswinc, .reset = NULL },
9d2a55b403eea2 Xiang Chen        2023-07-14  2248  	{ PMU_SYS_REG(PMSELR_EL0),
0ab410a93d627a Marc Zyngier      2021-07-19  2249  	  .access = access_pmselr, .reset = reset_pmselr, .reg = PMSELR_EL0 },
9d2a55b403eea2 Xiang Chen        2023-07-14  2250  	{ PMU_SYS_REG(PMCEID0_EL0),
11663111cd49b4 Marc Zyngier      2021-01-06  2251  	  .access = access_pmceid, .reset = NULL },
9d2a55b403eea2 Xiang Chen        2023-07-14  2252  	{ PMU_SYS_REG(PMCEID1_EL0),
11663111cd49b4 Marc Zyngier      2021-01-06  2253  	  .access = access_pmceid, .reset = NULL },
9d2a55b403eea2 Xiang Chen        2023-07-14  2254  	{ PMU_SYS_REG(PMCCNTR_EL0),
9228b26194d1cc Reiji Watanabe    2023-03-12  2255  	  .access = access_pmu_evcntr, .reset = reset_unknown,
9228b26194d1cc Reiji Watanabe    2023-03-12  2256  	  .reg = PMCCNTR_EL0, .get_user = get_pmu_evcntr},
9d2a55b403eea2 Xiang Chen        2023-07-14  2257  	{ PMU_SYS_REG(PMXEVTYPER_EL0),
11663111cd49b4 Marc Zyngier      2021-01-06  2258  	  .access = access_pmu_evtyper, .reset = NULL },
9d2a55b403eea2 Xiang Chen        2023-07-14  2259  	{ PMU_SYS_REG(PMXEVCNTR_EL0),
11663111cd49b4 Marc Zyngier      2021-01-06  2260  	  .access = access_pmu_evcntr, .reset = NULL },
174ed3e47591d5 Mark Rutland      2017-01-20  2261  	/*
174ed3e47591d5 Mark Rutland      2017-01-20  2262  	 * PMUSERENR_EL0 resets as unknown in 64bit mode while it resets as zero
d692b8ad6ec481 Shannon Zhao      2015-09-08  2263  	 * in 32bit mode. Here we choose to reset it as zero for consistency.
d692b8ad6ec481 Shannon Zhao      2015-09-08  2264  	 */
9d2a55b403eea2 Xiang Chen        2023-07-14  2265  	{ PMU_SYS_REG(PMUSERENR_EL0), .access = access_pmuserenr,
11663111cd49b4 Marc Zyngier      2021-01-06  2266  	  .reset = reset_val, .reg = PMUSERENR_EL0, .val = 0 },
9d2a55b403eea2 Xiang Chen        2023-07-14  2267  	{ PMU_SYS_REG(PMOVSSET_EL0),
11663111cd49b4 Marc Zyngier      2021-01-06  2268  	  .access = access_pmovs, .reg = PMOVSSET_EL0 },
7c8c5e6a9101ea Marc Zyngier      2012-12-10  2269
851050a573e1d2 Mark Rutland      2017-01-19  2270  	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
851050a573e1d2 Mark Rutland      2017-01-19  2271  	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
90807748ca3ac4 Mark Brown        2022-04-19  2272  	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
4fcdf106a4330b Ionela Voinescu   2020-03-05  2273
ed4ffaf49bf9ce Marc Zyngier      2020-11-10  2274  	{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
ed4ffaf49bf9ce Marc Zyngier      2020-11-10  2275
338b17933a6077 Marc Zyngier      2020-11-10  2276  	{ SYS_DESC(SYS_AMCR_EL0), undef_access },
338b17933a6077 Marc Zyngier      2020-11-10  2277  	{ SYS_DESC(SYS_AMCFGR_EL0), undef_access },
338b17933a6077 Marc Zyngier      2020-11-10  2278  	{ SYS_DESC(SYS_AMCGCR_EL0), undef_access },
338b17933a6077 Marc Zyngier      2020-11-10  2279  	{ SYS_DESC(SYS_AMUSERENR_EL0), undef_access },
338b17933a6077 Marc Zyngier      2020-11-10  2280  	{ SYS_DESC(SYS_AMCNTENCLR0_EL0), undef_access },
338b17933a6077 Marc Zyngier      2020-11-10  2281  	{ SYS_DESC(SYS_AMCNTENSET0_EL0), undef_access },
338b17933a6077 Marc Zyngier      2020-11-10  2282  	{ SYS_DESC(SYS_AMCNTENCLR1_EL0), undef_access },
338b17933a6077 Marc Zyngier      2020-11-10  2283  	{ SYS_DESC(SYS_AMCNTENSET1_EL0), undef_access },
4fcdf106a4330b Ionela Voinescu   2020-03-05  2284  	AMU_AMEVCNTR0_EL0(0),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2285  	AMU_AMEVCNTR0_EL0(1),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2286  	AMU_AMEVCNTR0_EL0(2),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2287  	AMU_AMEVCNTR0_EL0(3),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2288  	AMU_AMEVCNTR0_EL0(4),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2289  	AMU_AMEVCNTR0_EL0(5),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2290  	AMU_AMEVCNTR0_EL0(6),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2291  	AMU_AMEVCNTR0_EL0(7),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2292  	AMU_AMEVCNTR0_EL0(8),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2293  	AMU_AMEVCNTR0_EL0(9),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2294  	AMU_AMEVCNTR0_EL0(10),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2295  	AMU_AMEVCNTR0_EL0(11),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2296  	AMU_AMEVCNTR0_EL0(12),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2297  	AMU_AMEVCNTR0_EL0(13),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2298  	AMU_AMEVCNTR0_EL0(14),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2299  	AMU_AMEVCNTR0_EL0(15),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2300  	AMU_AMEVTYPER0_EL0(0),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2301  	AMU_AMEVTYPER0_EL0(1),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2302  	AMU_AMEVTYPER0_EL0(2),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2303  	AMU_AMEVTYPER0_EL0(3),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2304  	AMU_AMEVTYPER0_EL0(4),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2305  	AMU_AMEVTYPER0_EL0(5),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2306  	AMU_AMEVTYPER0_EL0(6),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2307  	AMU_AMEVTYPER0_EL0(7),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2308  	AMU_AMEVTYPER0_EL0(8),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2309  	AMU_AMEVTYPER0_EL0(9),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2310  	AMU_AMEVTYPER0_EL0(10),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2311  	AMU_AMEVTYPER0_EL0(11),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2312  	AMU_AMEVTYPER0_EL0(12),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2313  	AMU_AMEVTYPER0_EL0(13),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2314  	AMU_AMEVTYPER0_EL0(14),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2315  	AMU_AMEVTYPER0_EL0(15),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2316  	AMU_AMEVCNTR1_EL0(0),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2317  	AMU_AMEVCNTR1_EL0(1),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2318  	AMU_AMEVCNTR1_EL0(2),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2319  	AMU_AMEVCNTR1_EL0(3),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2320  	AMU_AMEVCNTR1_EL0(4),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2321  	AMU_AMEVCNTR1_EL0(5),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2322  	AMU_AMEVCNTR1_EL0(6),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2323  	AMU_AMEVCNTR1_EL0(7),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2324  	AMU_AMEVCNTR1_EL0(8),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2325  	AMU_AMEVCNTR1_EL0(9),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2326  	AMU_AMEVCNTR1_EL0(10),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2327  	AMU_AMEVCNTR1_EL0(11),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2328  	AMU_AMEVCNTR1_EL0(12),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2329  	AMU_AMEVCNTR1_EL0(13),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2330  	AMU_AMEVCNTR1_EL0(14),
4fcdf106a4330b Ionela Voinescu   2020-03-05  2331  	AMU_AMEVCNTR1_EL0(15),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2332  	AMU_AMEVTYPER1_EL0(0),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2333  	AMU_AMEVTYPER1_EL0(1),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2334  	AMU_AMEVTYPER1_EL0(2),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2335  	AMU_AMEVTYPER1_EL0(3),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2336  	AMU_AMEVTYPER1_EL0(4),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2337  	AMU_AMEVTYPER1_EL0(5),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2338  	AMU_AMEVTYPER1_EL0(6),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2339  	AMU_AMEVTYPER1_EL0(7),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2340  	AMU_AMEVTYPER1_EL0(8),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2341  	AMU_AMEVTYPER1_EL0(9),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2342  	AMU_AMEVTYPER1_EL0(10),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2343  	AMU_AMEVTYPER1_EL0(11),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2344  	AMU_AMEVTYPER1_EL0(12),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2345  	AMU_AMEVTYPER1_EL0(13),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2346  	AMU_AMEVTYPER1_EL0(14),
493cf9b723bcc8 Vladimir Murzin   2020-07-21  2347  	AMU_AMEVTYPER1_EL0(15),
62a89c44954f09 Marc Zyngier      2013-02-07  2348
c605ee245097d0 Marc Zyngier      2023-03-30  2349  	{ SYS_DESC(SYS_CNTPCT_EL0), access_arch_timer },
c605ee245097d0 Marc Zyngier      2023-03-30  2350  	{ SYS_DESC(SYS_CNTPCTSS_EL0), access_arch_timer },
84135d3d18da2f Andre Przywara    2018-07-05  2351  	{ SYS_DESC(SYS_CNTP_TVAL_EL0), access_arch_timer },
84135d3d18da2f Andre Przywara    2018-07-05  2352  	{ SYS_DESC(SYS_CNTP_CTL_EL0), access_arch_timer },
84135d3d18da2f Andre Przywara    2018-07-05  2353  	{ SYS_DESC(SYS_CNTP_CVAL_EL0), access_arch_timer },
c9a3c58f01fb0a Jintack Lim       2017-02-03  2354
051ff581ce70e8 Shannon Zhao      2015-12-08  2355  	/* PMEVCNTRn_EL0 */
051ff581ce70e8 Shannon Zhao      2015-12-08  2356  	PMU_PMEVCNTR_EL0(0),
051ff581ce70e8 Shannon Zhao      2015-12-08  2357  	PMU_PMEVCNTR_EL0(1),
051ff581ce70e8 Shannon Zhao      2015-12-08  2358  	PMU_PMEVCNTR_EL0(2),
051ff581ce70e8 Shannon Zhao      2015-12-08  2359  	PMU_PMEVCNTR_EL0(3),
051ff581ce70e8 Shannon Zhao      2015-12-08  2360  	PMU_PMEVCNTR_EL0(4),
051ff581ce70e8 Shannon Zhao      2015-12-08  2361  	PMU_PMEVCNTR_EL0(5),
051ff581ce70e8 Shannon Zhao      2015-12-08  2362  	PMU_PMEVCNTR_EL0(6),
051ff581ce70e8 Shannon Zhao      2015-12-08  2363  	PMU_PMEVCNTR_EL0(7),
051ff581ce70e8 Shannon Zhao      2015-12-08  2364  	PMU_PMEVCNTR_EL0(8),
051ff581ce70e8 Shannon Zhao      2015-12-08  2365  	PMU_PMEVCNTR_EL0(9),
051ff581ce70e8 Shannon Zhao      2015-12-08  2366  	PMU_PMEVCNTR_EL0(10),
051ff581ce70e8 Shannon Zhao      2015-12-08  2367  	PMU_PMEVCNTR_EL0(11),
051ff581ce70e8 Shannon Zhao      2015-12-08  2368  	PMU_PMEVCNTR_EL0(12),
051ff581ce70e8 Shannon Zhao      2015-12-08  2369  	PMU_PMEVCNTR_EL0(13),
051ff581ce70e8 Shannon Zhao      2015-12-08  2370  	PMU_PMEVCNTR_EL0(14),
051ff581ce70e8 Shannon Zhao      2015-12-08  2371  	PMU_PMEVCNTR_EL0(15),
051ff581ce70e8 Shannon Zhao      2015-12-08  2372  	PMU_PMEVCNTR_EL0(16),
051ff581ce70e8 Shannon Zhao      2015-12-08  2373  	PMU_PMEVCNTR_EL0(17),
051ff581ce70e8 Shannon Zhao      2015-12-08  2374  	PMU_PMEVCNTR_EL0(18),
051ff581ce70e8 Shannon Zhao      2015-12-08  2375  	PMU_PMEVCNTR_EL0(19),
051ff581ce70e8 Shannon Zhao      2015-12-08  2376  	PMU_PMEVCNTR_EL0(20),
051ff581ce70e8 Shannon Zhao      2015-12-08  2377  	PMU_PMEVCNTR_EL0(21),
051ff581ce70e8 Shannon Zhao      2015-12-08  2378  	PMU_PMEVCNTR_EL0(22),
051ff581ce70e8 Shannon Zhao      2015-12-08  2379  	PMU_PMEVCNTR_EL0(23),
051ff581ce70e8 Shannon Zhao      2015-12-08  2380  	PMU_PMEVCNTR_EL0(24),
051ff581ce70e8 Shannon Zhao      2015-12-08  2381  	PMU_PMEVCNTR_EL0(25),
051ff581ce70e8 Shannon Zhao      2015-12-08  2382  	PMU_PMEVCNTR_EL0(26),
051ff581ce70e8 Shannon Zhao      2015-12-08  2383  	PMU_PMEVCNTR_EL0(27),
051ff581ce70e8 Shannon Zhao      2015-12-08  2384  	PMU_PMEVCNTR_EL0(28),
051ff581ce70e8 Shannon Zhao      2015-12-08  2385  	PMU_PMEVCNTR_EL0(29),
051ff581ce70e8 Shannon Zhao      2015-12-08  2386  	PMU_PMEVCNTR_EL0(30),
9feb21ac57d530 Shannon Zhao      2016-02-23  2387  	/* PMEVTYPERn_EL0 */
9feb21ac57d530 Shannon Zhao      2016-02-23  2388  	PMU_PMEVTYPER_EL0(0),
9feb21ac57d530 Shannon Zhao      2016-02-23  2389  	PMU_PMEVTYPER_EL0(1),
9feb21ac57d530 Shannon Zhao      2016-02-23  2390  	PMU_PMEVTYPER_EL0(2),
9feb21ac57d530 Shannon Zhao      2016-02-23  2391  	PMU_PMEVTYPER_EL0(3),
9feb21ac57d530 Shannon Zhao      2016-02-23  2392  	PMU_PMEVTYPER_EL0(4),
9feb21ac57d530 Shannon Zhao      2016-02-23  2393  	PMU_PMEVTYPER_EL0(5),
9feb21ac57d530 Shannon Zhao      2016-02-23  2394  	PMU_PMEVTYPER_EL0(6),
9feb21ac57d530 Shannon Zhao      2016-02-23  2395  	PMU_PMEVTYPER_EL0(7),
9feb21ac57d530 Shannon Zhao      2016-02-23  2396  	PMU_PMEVTYPER_EL0(8),
9feb21ac57d530 Shannon Zhao      2016-02-23  2397  	PMU_PMEVTYPER_EL0(9),
9feb21ac57d530 Shannon Zhao      2016-02-23  2398  	PMU_PMEVTYPER_EL0(10),
9feb21ac57d530 Shannon Zhao      2016-02-23  2399  	PMU_PMEVTYPER_EL0(11),
9feb21ac57d530 Shannon Zhao      2016-02-23  2400  	PMU_PMEVTYPER_EL0(12),
9feb21ac57d530 Shannon Zhao      2016-02-23  2401  	PMU_PMEVTYPER_EL0(13),
9feb21ac57d530 Shannon Zhao      2016-02-23  2402  	PMU_PMEVTYPER_EL0(14),
9feb21ac57d530 Shannon Zhao      2016-02-23  2403  	PMU_PMEVTYPER_EL0(15),
9feb21ac57d530 Shannon Zhao      2016-02-23  2404  	PMU_PMEVTYPER_EL0(16),
9feb21ac57d530 Shannon Zhao      2016-02-23  2405  	PMU_PMEVTYPER_EL0(17),
9feb21ac57d530 Shannon Zhao      2016-02-23  2406  	PMU_PMEVTYPER_EL0(18),
9feb21ac57d530 Shannon Zhao      2016-02-23  2407  	PMU_PMEVTYPER_EL0(19),
9feb21ac57d530 Shannon Zhao      2016-02-23  2408  	PMU_PMEVTYPER_EL0(20),
9feb21ac57d530 Shannon Zhao      2016-02-23  2409  	PMU_PMEVTYPER_EL0(21),
9feb21ac57d530 Shannon Zhao      2016-02-23  2410  	PMU_PMEVTYPER_EL0(22),
9feb21ac57d530 Shannon Zhao      2016-02-23  2411  	PMU_PMEVTYPER_EL0(23),
9feb21ac57d530 Shannon Zhao      2016-02-23  2412  	PMU_PMEVTYPER_EL0(24),
9feb21ac57d530 Shannon Zhao      2016-02-23  2413  	PMU_PMEVTYPER_EL0(25),
9feb21ac57d530 Shannon Zhao      2016-02-23  2414  	PMU_PMEVTYPER_EL0(26),
9feb21ac57d530 Shannon Zhao      2016-02-23  2415  	PMU_PMEVTYPER_EL0(27),
9feb21ac57d530 Shannon Zhao      2016-02-23  2416  	PMU_PMEVTYPER_EL0(28),
9feb21ac57d530 Shannon Zhao      2016-02-23  2417  	PMU_PMEVTYPER_EL0(29),
9feb21ac57d530 Shannon Zhao      2016-02-23  2418  	PMU_PMEVTYPER_EL0(30),
174ed3e47591d5 Mark Rutland      2017-01-20  2419  	/*
174ed3e47591d5 Mark Rutland      2017-01-20  2420  	 * PMCCFILTR_EL0 resets as unknown in 64bit mode while it resets as zero
9feb21ac57d530 Shannon Zhao      2016-02-23  2421  	 * in 32bit mode. Here we choose to reset it as zero for consistency.
9feb21ac57d530 Shannon Zhao      2016-02-23  2422  	 */
9d2a55b403eea2 Xiang Chen        2023-07-14  2423  	{ PMU_SYS_REG(PMCCFILTR_EL0), .access = access_pmu_evtyper,
11663111cd49b4 Marc Zyngier      2021-01-06  2424  	  .reset = reset_val, .reg = PMCCFILTR_EL0, .val = 0 },
051ff581ce70e8 Shannon Zhao      2015-12-08  2425
6ff9dc238a53f4 Jintack Lim       2023-02-09  2426  	EL2_REG(VPIDR_EL2, access_rw, reset_unknown, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2427  	EL2_REG(VMPIDR_EL2, access_rw, reset_unknown, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2428  	EL2_REG(SCTLR_EL2, access_rw, reset_val, SCTLR_EL2_RES1),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2429  	EL2_REG(ACTLR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2430  	EL2_REG(HCR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2431  	EL2_REG(MDCR_EL2, access_rw, reset_val, 0),
75c76ab5a641b6 Marc Zyngier      2023-06-09  2432  	EL2_REG(CPTR_EL2, access_rw, reset_val, CPTR_NVHE_EL2_RES1),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2433  	EL2_REG(HSTR_EL2, access_rw, reset_val, 0),
50d2fe4648c50e Marc Zyngier      2023-08-15  2434  	EL2_REG(HFGRTR_EL2, access_rw, reset_val, 0),
50d2fe4648c50e Marc Zyngier      2023-08-15  2435  	EL2_REG(HFGWTR_EL2, access_rw, reset_val, 0),
50d2fe4648c50e Marc Zyngier      2023-08-15  2436  	EL2_REG(HFGITR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2437  	EL2_REG(HACR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2438
03fb54d0aa73cc Marc Zyngier      2023-08-15  2439  	EL2_REG(HCRX_EL2, access_rw, reset_val, 0),
03fb54d0aa73cc Marc Zyngier      2023-08-15  2440
6ff9dc238a53f4 Jintack Lim       2023-02-09  2441  	EL2_REG(TTBR0_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2442  	EL2_REG(TTBR1_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2443  	EL2_REG(TCR_EL2, access_rw, reset_val, TCR_EL2_RES1),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2444  	EL2_REG(VTTBR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2445  	EL2_REG(VTCR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2446
851050a573e1d2 Mark Rutland      2017-01-19  2447  	{ SYS_DESC(SYS_DACR32_EL2), NULL, reset_unknown, DACR32_EL2 },
50d2fe4648c50e Marc Zyngier      2023-08-15  2448  	EL2_REG(HDFGRTR_EL2, access_rw, reset_val, 0),
50d2fe4648c50e Marc Zyngier      2023-08-15  2449  	EL2_REG(HDFGWTR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2450  	EL2_REG(SPSR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2451  	EL2_REG(ELR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2452  	{ SYS_DESC(SYS_SP_EL1), access_sp_el1},
6ff9dc238a53f4 Jintack Lim       2023-02-09  2453
851050a573e1d2 Mark Rutland      2017-01-19  2454  	{ SYS_DESC(SYS_IFSR32_EL2), NULL, reset_unknown, IFSR32_EL2 },
6ff9dc238a53f4 Jintack Lim       2023-02-09  2455  	EL2_REG(AFSR0_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2456  	EL2_REG(AFSR1_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2457  	EL2_REG(ESR_EL2, access_rw, reset_val, 0),
c88b093693ccbe Dave Martin       2019-02-21  2458  	{ SYS_DESC(SYS_FPEXC32_EL2), NULL, reset_val, FPEXC32_EL2, 0x700 },
6ff9dc238a53f4 Jintack Lim       2023-02-09  2459
6ff9dc238a53f4 Jintack Lim       2023-02-09  2460  	EL2_REG(FAR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2461  	EL2_REG(HPFAR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2462
6ff9dc238a53f4 Jintack Lim       2023-02-09  2463  	EL2_REG(MAIR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2464  	EL2_REG(AMAIR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2465
6ff9dc238a53f4 Jintack Lim       2023-02-09  2466  	EL2_REG(VBAR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2467  	EL2_REG(RVBAR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2468  	{ SYS_DESC(SYS_RMR_EL2), trap_undef },
6ff9dc238a53f4 Jintack Lim       2023-02-09  2469
6ff9dc238a53f4 Jintack Lim       2023-02-09  2470  	EL2_REG(CONTEXTIDR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2471  	EL2_REG(TPIDR_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2472
6ff9dc238a53f4 Jintack Lim       2023-02-09  2473  	EL2_REG(CNTVOFF_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2474  	EL2_REG(CNTHCTL_EL2, access_rw, reset_val, 0),
6ff9dc238a53f4 Jintack Lim       2023-02-09  2475
280b748e871e5a Jintack Lim       2023-02-09  2476  	EL12_REG(SCTLR, access_vm_reg, reset_val, 0x00C50078),
280b748e871e5a Jintack Lim       2023-02-09  2477  	EL12_REG(CPACR, access_rw, reset_val, 0),
280b748e871e5a Jintack Lim       2023-02-09  2478  	EL12_REG(TTBR0, access_vm_reg, reset_unknown, 0),
280b748e871e5a Jintack Lim       2023-02-09  2479  	EL12_REG(TTBR1, access_vm_reg, reset_unknown, 0),
280b748e871e5a Jintack Lim       2023-02-09  2480  	EL12_REG(TCR, access_vm_reg, reset_val, 0),
280b748e871e5a Jintack Lim       2023-02-09  2481  	{ SYS_DESC(SYS_SPSR_EL12), access_spsr},
280b748e871e5a Jintack Lim       2023-02-09  2482  	{ SYS_DESC(SYS_ELR_EL12), access_elr},
280b748e871e5a Jintack Lim       2023-02-09  2483  	EL12_REG(AFSR0, access_vm_reg, reset_unknown, 0),
280b748e871e5a Jintack Lim       2023-02-09  2484  	EL12_REG(AFSR1, access_vm_reg, reset_unknown, 0),
280b748e871e5a Jintack Lim       2023-02-09  2485  	EL12_REG(ESR, access_vm_reg, reset_unknown, 0),
280b748e871e5a Jintack Lim       2023-02-09  2486  	EL12_REG(FAR, access_vm_reg, reset_unknown, 0),
280b748e871e5a Jintack Lim       2023-02-09  2487  	EL12_REG(MAIR, access_vm_reg, reset_unknown, 0),
280b748e871e5a Jintack Lim       2023-02-09  2488  	EL12_REG(AMAIR, access_vm_reg, reset_amair_el1, 0),
280b748e871e5a Jintack Lim       2023-02-09  2489  	EL12_REG(VBAR, access_rw, reset_val, 0),
280b748e871e5a Jintack Lim       2023-02-09  2490  	EL12_REG(CONTEXTIDR, access_vm_reg, reset_val, 0),
280b748e871e5a Jintack Lim       2023-02-09  2491  	EL12_REG(CNTKCTL, access_rw, reset_val, 0),
280b748e871e5a Jintack Lim       2023-02-09  2492
6ff9dc238a53f4 Jintack Lim       2023-02-09  2493  	EL2_REG(SP_EL2, NULL, reset_unknown, 0),
62a89c44954f09 Marc Zyngier      2013-02-07  2494  };
62a89c44954f09 Marc Zyngier      2013-02-07  2495

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
