Return-Path: <linux-kernel+bounces-2452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70609815D58
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81ACF1C21436
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7215D4;
	Sun, 17 Dec 2023 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xbs8mlg8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759B1104
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702785802; x=1734321802;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oaSVt/K2KuS23jnKVt2xZCfLpUTrvDBpxzHCM4QrYUw=;
  b=Xbs8mlg8F8HZVjr0NylqZBA5Xt92Qc4L5cHRVr4rCjgEjiEClx9aLbKQ
   GUPISTe1ieDLUAhVgRdHGTjhzPYwGt6FR+R2tJc4M+zbNIOYkd25jPgYG
   wPyBiWI+7eboMRT4qaEVS0GEQOf4UAA2woSC8aqtc+F2M8XbUnca/Og6+
   3BpgKPS8lboqA8V9HwexP3PVG94+Bd8pGwAgoPCoXv3iEHDclNx94VRGC
   KEmAvuQkSLvK41Ll6Fj6SkuHeF2JgIC6FiFiLZi/it5X0PMcB9fog/3MN
   IC4TjXlyBzdUm+VHC448/F3v22KUD+gHRnXvmRO5xsoc3j6pEpxb3MBLL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="375551373"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="375551373"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 20:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="768443175"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="768443175"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2023 20:03:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEiN2-0002c7-0L;
	Sun, 17 Dec 2023 04:03:16 +0000
Date: Sun, 17 Dec 2023 12:02:32 +0800
From: kernel test robot <lkp@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: htmldocs: ./include/crypto/hash.h:245: warning: Excess struct member
 'digestsize' description in 'shash_alg'
Message-ID: <202312171213.bGRwBUze-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 42808e5dc602c12ef3eb42cf96cb416b55205fa4 crypto: hash - Count error stats differently
date:   9 months ago
reproduce: (https://download.01.org/0day-ci/archive/20231217/202312171213.bGRwBUze-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171213.bGRwBUze-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./include/crypto/hash.h:245: warning: Excess struct member 'digestsize' description in 'shash_alg'
>> ./include/crypto/hash.h:245: warning: Excess struct member 'statesize' description in 'shash_alg'
>> ./include/crypto/hash.h:245: warning: Excess struct member 'stat' description in 'shash_alg'
>> ./include/crypto/hash.h:245: warning: Excess struct member 'base' description in 'shash_alg'

vim +245 ./include/crypto/hash.h

    43	
    44	/**
    45	 * struct hash_alg_common - define properties of message digest
    46	 * @stat: Statistics for hash algorithm.
    47	 * @digestsize: Size of the result of the transformation. A buffer of this size
    48	 *	        must be available to the @final and @finup calls, so they can
    49	 *	        store the resulting hash into it. For various predefined sizes,
    50	 *	        search include/crypto/ using
    51	 *	        git grep _DIGEST_SIZE include/crypto.
    52	 * @statesize: Size of the block for partial state of the transformation. A
    53	 *	       buffer of this size must be passed to the @export function as it
    54	 *	       will save the partial state of the transformation into it. On the
    55	 *	       other side, the @import function will load the state from a
    56	 *	       buffer of this size as well.
    57	 * @base: Start of data structure of cipher algorithm. The common data
    58	 *	  structure of crypto_alg contains information common to all ciphers.
    59	 *	  The hash_alg_common data structure now adds the hash-specific
    60	 *	  information.
    61	 */
    62	#define HASH_ALG_COMMON {		\
    63		HASH_ALG_COMMON_STAT		\
    64						\
    65		unsigned int digestsize;	\
    66		unsigned int statesize;		\
    67						\
    68		struct crypto_alg base;		\
  > 69	}
    70	struct hash_alg_common HASH_ALG_COMMON;
    71	
    72	struct ahash_request {
    73		struct crypto_async_request base;
    74	
    75		unsigned int nbytes;
    76		struct scatterlist *src;
    77		u8 *result;
    78	
    79		/* This field may only be used by the ahash API code. */
    80		void *priv;
    81	
    82		void *__ctx[] CRYPTO_MINALIGN_ATTR;
    83	};
    84	
    85	/**
    86	 * struct ahash_alg - asynchronous message digest definition
    87	 * @init: **[mandatory]** Initialize the transformation context. Intended only to initialize the
    88	 *	  state of the HASH transformation at the beginning. This shall fill in
    89	 *	  the internal structures used during the entire duration of the whole
    90	 *	  transformation. No data processing happens at this point. Driver code
    91	 *	  implementation must not use req->result.
    92	 * @update: **[mandatory]** Push a chunk of data into the driver for transformation. This
    93	 *	   function actually pushes blocks of data from upper layers into the
    94	 *	   driver, which then passes those to the hardware as seen fit. This
    95	 *	   function must not finalize the HASH transformation by calculating the
    96	 *	   final message digest as this only adds more data into the
    97	 *	   transformation. This function shall not modify the transformation
    98	 *	   context, as this function may be called in parallel with the same
    99	 *	   transformation object. Data processing can happen synchronously
   100	 *	   [SHASH] or asynchronously [AHASH] at this point. Driver must not use
   101	 *	   req->result.
   102	 * @final: **[mandatory]** Retrieve result from the driver. This function finalizes the
   103	 *	   transformation and retrieves the resulting hash from the driver and
   104	 *	   pushes it back to upper layers. No data processing happens at this
   105	 *	   point unless hardware requires it to finish the transformation
   106	 *	   (then the data buffered by the device driver is processed).
   107	 * @finup: **[optional]** Combination of @update and @final. This function is effectively a
   108	 *	   combination of @update and @final calls issued in sequence. As some
   109	 *	   hardware cannot do @update and @final separately, this callback was
   110	 *	   added to allow such hardware to be used at least by IPsec. Data
   111	 *	   processing can happen synchronously [SHASH] or asynchronously [AHASH]
   112	 *	   at this point.
   113	 * @digest: Combination of @init and @update and @final. This function
   114	 *	    effectively behaves as the entire chain of operations, @init,
   115	 *	    @update and @final issued in sequence. Just like @finup, this was
   116	 *	    added for hardware which cannot do even the @finup, but can only do
   117	 *	    the whole transformation in one run. Data processing can happen
   118	 *	    synchronously [SHASH] or asynchronously [AHASH] at this point.
   119	 * @setkey: Set optional key used by the hashing algorithm. Intended to push
   120	 *	    optional key used by the hashing algorithm from upper layers into
   121	 *	    the driver. This function can store the key in the transformation
   122	 *	    context or can outright program it into the hardware. In the former
   123	 *	    case, one must be careful to program the key into the hardware at
   124	 *	    appropriate time and one must be careful that .setkey() can be
   125	 *	    called multiple times during the existence of the transformation
   126	 *	    object. Not  all hashing algorithms do implement this function as it
   127	 *	    is only needed for keyed message digests. SHAx/MDx/CRCx do NOT
   128	 *	    implement this function. HMAC(MDx)/HMAC(SHAx)/CMAC(AES) do implement
   129	 *	    this function. This function must be called before any other of the
   130	 *	    @init, @update, @final, @finup, @digest is called. No data
   131	 *	    processing happens at this point.
   132	 * @export: Export partial state of the transformation. This function dumps the
   133	 *	    entire state of the ongoing transformation into a provided block of
   134	 *	    data so it can be @import 'ed back later on. This is useful in case
   135	 *	    you want to save partial result of the transformation after
   136	 *	    processing certain amount of data and reload this partial result
   137	 *	    multiple times later on for multiple re-use. No data processing
   138	 *	    happens at this point. Driver must not use req->result.
   139	 * @import: Import partial state of the transformation. This function loads the
   140	 *	    entire state of the ongoing transformation from a provided block of
   141	 *	    data so the transformation can continue from this point onward. No
   142	 *	    data processing happens at this point. Driver must not use
   143	 *	    req->result.
   144	 * @init_tfm: Initialize the cryptographic transformation object.
   145	 *	      This function is called only once at the instantiation
   146	 *	      time, right after the transformation context was
   147	 *	      allocated. In case the cryptographic hardware has
   148	 *	      some special requirements which need to be handled
   149	 *	      by software, this function shall check for the precise
   150	 *	      requirement of the transformation and put any software
   151	 *	      fallbacks in place.
   152	 * @exit_tfm: Deinitialize the cryptographic transformation object.
   153	 *	      This is a counterpart to @init_tfm, used to remove
   154	 *	      various changes set in @init_tfm.
   155	 * @halg: see struct hash_alg_common
   156	 */
   157	struct ahash_alg {
   158		int (*init)(struct ahash_request *req);
   159		int (*update)(struct ahash_request *req);
   160		int (*final)(struct ahash_request *req);
   161		int (*finup)(struct ahash_request *req);
   162		int (*digest)(struct ahash_request *req);
   163		int (*export)(struct ahash_request *req, void *out);
   164		int (*import)(struct ahash_request *req, const void *in);
   165		int (*setkey)(struct crypto_ahash *tfm, const u8 *key,
   166			      unsigned int keylen);
   167		int (*init_tfm)(struct crypto_ahash *tfm);
   168		void (*exit_tfm)(struct crypto_ahash *tfm);
   169	
   170		struct hash_alg_common halg;
   171	};
   172	
   173	struct shash_desc {
   174		struct crypto_shash *tfm;
   175		void *__ctx[] __aligned(ARCH_SLAB_MINALIGN);
   176	};
   177	
   178	#define HASH_MAX_DIGESTSIZE	 64
   179	
   180	/*
   181	 * Worst case is hmac(sha3-224-generic).  Its context is a nested 'shash_desc'
   182	 * containing a 'struct sha3_state'.
   183	 */
   184	#define HASH_MAX_DESCSIZE	(sizeof(struct shash_desc) + 360)
   185	
   186	#define HASH_MAX_STATESIZE	512
   187	
   188	#define SHASH_DESC_ON_STACK(shash, ctx)					     \
   189		char __##shash##_desc[sizeof(struct shash_desc) + HASH_MAX_DESCSIZE] \
   190			__aligned(__alignof__(struct shash_desc));		     \
   191		struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
   192	
   193	/**
   194	 * struct shash_alg - synchronous message digest definition
   195	 * @init: see struct ahash_alg
   196	 * @update: see struct ahash_alg
   197	 * @final: see struct ahash_alg
   198	 * @finup: see struct ahash_alg
   199	 * @digest: see struct ahash_alg
   200	 * @export: see struct ahash_alg
   201	 * @import: see struct ahash_alg
   202	 * @setkey: see struct ahash_alg
   203	 * @init_tfm: Initialize the cryptographic transformation object.
   204	 *	      This function is called only once at the instantiation
   205	 *	      time, right after the transformation context was
   206	 *	      allocated. In case the cryptographic hardware has
   207	 *	      some special requirements which need to be handled
   208	 *	      by software, this function shall check for the precise
   209	 *	      requirement of the transformation and put any software
   210	 *	      fallbacks in place.
   211	 * @exit_tfm: Deinitialize the cryptographic transformation object.
   212	 *	      This is a counterpart to @init_tfm, used to remove
   213	 *	      various changes set in @init_tfm.
   214	 * @digestsize: see struct ahash_alg
   215	 * @statesize: see struct ahash_alg
   216	 * @descsize: Size of the operational state for the message digest. This state
   217	 * 	      size is the memory size that needs to be allocated for
   218	 *	      shash_desc.__ctx
   219	 * @stat: Statistics for hash algorithm.
   220	 * @base: internally used
   221	 * @halg: see struct hash_alg_common
   222	 */
   223	struct shash_alg {
   224		int (*init)(struct shash_desc *desc);
   225		int (*update)(struct shash_desc *desc, const u8 *data,
   226			      unsigned int len);
   227		int (*final)(struct shash_desc *desc, u8 *out);
   228		int (*finup)(struct shash_desc *desc, const u8 *data,
   229			     unsigned int len, u8 *out);
   230		int (*digest)(struct shash_desc *desc, const u8 *data,
   231			      unsigned int len, u8 *out);
   232		int (*export)(struct shash_desc *desc, void *out);
   233		int (*import)(struct shash_desc *desc, const void *in);
   234		int (*setkey)(struct crypto_shash *tfm, const u8 *key,
   235			      unsigned int keylen);
   236		int (*init_tfm)(struct crypto_shash *tfm);
   237		void (*exit_tfm)(struct crypto_shash *tfm);
   238	
   239		unsigned int descsize;
   240	
   241		union {
   242			struct HASH_ALG_COMMON;
   243			struct hash_alg_common halg;
   244		};
 > 245	};
   246	#undef HASH_ALG_COMMON
   247	#undef HASH_ALG_COMMON_STAT
   248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

