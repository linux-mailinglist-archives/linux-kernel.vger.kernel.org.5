Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1E8028ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 00:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjLCXLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 18:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLCXLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 18:11:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24766D3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701645082; x=1733181082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f0vn/d7PQ0FffchBDMgVcrSjmqsdKUY5dHA5DRdoGag=;
  b=bK3nGqDVqjcUS4uArRYJuLnk4Cq0PKvQlsT63LDxseXl4WfGZO+31ChO
   x6eMZdxtunAQlDy5uBF82g8d3BE8sSXUjJkGKOvMZknRgheywo+iKqGiV
   dgVV8wLBNmtGUMIb/9t2LugR4bWYZVSy7S062spjOJNTliEcHdjqjC3RK
   2oX6R/JJYGuN75dlCW74Gm4EO2glDsZnyy7bYpNazypeiFarZo4rACRuh
   nJuM27wIh0wGijH8knmYKqKP7S8OyBy6wyjLxuA2VLLniQ8oZwSIsSKu7
   XGc9fH/3/90XVhEa3EiF+usH+gK0PdXmhSmCDH+xsvpDiVDW5i74Ci+fa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="378697880"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="378697880"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 15:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="1101908221"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="1101908221"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Dec 2023 15:11:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9vcK-0007Ci-2r;
        Sun, 03 Dec 2023 23:11:16 +0000
Date:   Mon, 4 Dec 2023 07:10:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Lombard <clombard@linux.vnet.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Manoj Kumar <manoj@linux.vnet.ibm.com>
Subject: drivers/misc/cxl/flash.c:94:9: sparse: sparse: cast to restricted
 __be32
Message-ID: <202312040644.G4XuVY2n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 594ff7d067ca42676e27e2a7b5dcc0ff039d08ca cxl: Support to flash a new image on the adapter from a guest
date:   8 years ago
config: powerpc64-randconfig-r113-20231107 (https://download.01.org/0day-ci/archive/20231204/202312040644.G4XuVY2n-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312040644.G4XuVY2n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312040644.G4XuVY2n-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/misc/cxl/flash.c:28:16: sparse: sparse: symbol 'le' was not declared. Should it be static?
>> drivers/misc/cxl/flash.c:94:9: sparse: sparse: cast to restricted __be32
>> drivers/misc/cxl/flash.c:94:9: sparse: sparse: cast to restricted __be32
>> drivers/misc/cxl/flash.c:94:9: sparse: sparse: cast to restricted __be32
>> drivers/misc/cxl/flash.c:94:9: sparse: sparse: cast to restricted __be32
>> drivers/misc/cxl/flash.c:94:9: sparse: sparse: cast to restricted __be32
>> drivers/misc/cxl/flash.c:94:9: sparse: sparse: cast to restricted __be32
>> drivers/misc/cxl/flash.c:242:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] version @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:242:33: sparse:     expected unsigned short [usertype] version
   drivers/misc/cxl/flash.c:242:33: sparse:     got restricted __be16 [usertype]
>> drivers/misc/cxl/flash.c:243:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] vendor @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:243:32: sparse:     expected unsigned short [usertype] vendor
   drivers/misc/cxl/flash.c:243:32: sparse:     got restricted __be16 [usertype]
>> drivers/misc/cxl/flash.c:244:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] device @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:244:32: sparse:     expected unsigned short [usertype] device
   drivers/misc/cxl/flash.c:244:32: sparse:     got restricted __be16 [usertype]
>> drivers/misc/cxl/flash.c:245:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] subsystem_vendor @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:245:42: sparse:     expected unsigned short [usertype] subsystem_vendor
   drivers/misc/cxl/flash.c:245:42: sparse:     got restricted __be16 [usertype]
>> drivers/misc/cxl/flash.c:246:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] subsystem @@     got restricted __be16 [usertype] @@
   drivers/misc/cxl/flash.c:246:35: sparse:     expected unsigned short [usertype] subsystem
   drivers/misc/cxl/flash.c:246:35: sparse:     got restricted __be16 [usertype]
>> drivers/misc/cxl/flash.c:247:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] image_offset @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:247:38: sparse:     expected unsigned long long [usertype] image_offset
   drivers/misc/cxl/flash.c:247:38: sparse:     got restricted __be64 [usertype]
>> drivers/misc/cxl/flash.c:248:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] image_length @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:248:38: sparse:     expected unsigned long long [usertype] image_length
   drivers/misc/cxl/flash.c:248:38: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/flash.c:293:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void *[assigned] from @@
   drivers/misc/cxl/flash.c:293:42: sparse:     expected void const [noderef] <asn:1> *from
   drivers/misc/cxl/flash.c:293:42: sparse:     got void *[assigned] from
>> drivers/misc/cxl/flash.c:297:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] phys_addr @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:297:33: sparse:     expected unsigned long long [usertype] phys_addr
   drivers/misc/cxl/flash.c:297:33: sparse:     got restricted __be64 [usertype]
>> drivers/misc/cxl/flash.c:298:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:298:27: sparse:     expected unsigned long long [usertype] len
   drivers/misc/cxl/flash.c:298:27: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/flash.c:300:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/flash.c:300:35: sparse:     expected unsigned long long [usertype] len
   drivers/misc/cxl/flash.c:300:35: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/flash.c: In function 'update_devicetree':
   drivers/misc/cxl/flash.c:177:23: warning: variable 'drc_index' set but not used [-Wunused-but-set-variable]
     177 |         __be32 *data, drc_index, phandle;
         |                       ^~~~~~~~~

vim +94 drivers/misc/cxl/flash.c

    65	
    66	static int update_property(struct device_node *dn, const char *name,
    67				   u32 vd, char *value)
    68	{
    69		struct property *new_prop;
    70		u32 *val;
    71		int rc;
    72	
    73		new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
    74		if (!new_prop)
    75			return -ENOMEM;
    76	
    77		new_prop->name = kstrdup(name, GFP_KERNEL);
    78		if (!new_prop->name) {
    79			kfree(new_prop);
    80			return -ENOMEM;
    81		}
    82	
    83		new_prop->length = vd;
    84		new_prop->value = kzalloc(new_prop->length, GFP_KERNEL);
    85		if (!new_prop->value) {
    86			kfree(new_prop->name);
    87			kfree(new_prop);
    88			return -ENOMEM;
    89		}
    90		memcpy(new_prop->value, value, vd);
    91	
    92		val = (u32 *)new_prop->value;
    93		rc = cxl_update_properties(dn, new_prop);
  > 94		pr_devel("%s: update property (%s, length: %i, value: %#x)\n",
    95			  dn->name, name, vd, be32_to_cpu(*val));
    96	
    97		if (rc) {
    98			kfree(new_prop->name);
    99			kfree(new_prop->value);
   100			kfree(new_prop);
   101		}
   102		return rc;
   103	}
   104	
   105	static int update_node(__be32 phandle, s32 scope)
   106	{
   107		struct update_props_workarea *upwa;
   108		struct device_node *dn;
   109		int i, rc, ret;
   110		char *prop_data;
   111		char *buf;
   112		int token;
   113		u32 nprops;
   114		u32 vd;
   115	
   116		token = rtas_token("ibm,update-properties");
   117		if (token == RTAS_UNKNOWN_SERVICE)
   118			return -EINVAL;
   119	
   120		buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
   121		if (!buf)
   122			return -ENOMEM;
   123	
   124		dn = of_find_node_by_phandle(be32_to_cpu(phandle));
   125		if (!dn) {
   126			kfree(buf);
   127			return -ENOENT;
   128		}
   129	
   130		upwa = (struct update_props_workarea *)&buf[0];
   131		upwa->phandle = phandle;
   132		do {
   133			rc = rcall(token, buf, scope);
   134			if (rc < 0)
   135				break;
   136	
   137			prop_data = buf + sizeof(*upwa);
   138			nprops = be32_to_cpu(upwa->nprops);
   139	
   140			if (*prop_data == 0) {
   141				prop_data++;
   142				vd = be32_to_cpu(*(__be32 *)prop_data);
   143				prop_data += vd + sizeof(vd);
   144				nprops--;
   145			}
   146	
   147			for (i = 0; i < nprops; i++) {
   148				char *prop_name;
   149	
   150				prop_name = prop_data;
   151				prop_data += strlen(prop_name) + 1;
   152				vd = be32_to_cpu(*(__be32 *)prop_data);
   153				prop_data += sizeof(vd);
   154	
   155				if ((vd != 0x00000000) && (vd != 0x80000000)) {
   156					ret = update_property(dn, prop_name, vd,
   157							prop_data);
   158					if (ret)
   159						pr_err("cxl: Could not update property %s - %i\n",
   160						       prop_name, ret);
   161	
   162					prop_data += vd;
   163				}
   164			}
   165		} while (rc == 1);
   166	
   167		of_node_put(dn);
   168		kfree(buf);
   169		return rc;
   170	}
   171	
   172	static int update_devicetree(struct cxl *adapter, s32 scope)
   173	{
   174		struct update_nodes_workarea *unwa;
   175		u32 action, node_count;
   176		int token, rc, i;
   177		__be32 *data, drc_index, phandle;
   178		char *buf;
   179	
   180		token = rtas_token("ibm,update-nodes");
   181		if (token == RTAS_UNKNOWN_SERVICE)
   182			return -EINVAL;
   183	
   184		buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
   185		if (!buf)
   186			return -ENOMEM;
   187	
   188		unwa = (struct update_nodes_workarea *)&buf[0];
   189		unwa->unit_address = cpu_to_be64(adapter->guest->handle);
   190		do {
   191			rc = rcall(token, buf, scope);
   192			if (rc && rc != 1)
   193				break;
   194	
   195			data = (__be32 *)buf + 4;
   196			while (be32_to_cpu(*data) & NODE_ACTION_MASK) {
   197				action = be32_to_cpu(*data) & NODE_ACTION_MASK;
   198				node_count = be32_to_cpu(*data) & NODE_COUNT_MASK;
   199				pr_devel("device reconfiguration - action: %#x, nodes: %#x\n",
   200					 action, node_count);
   201				data++;
   202	
   203				for (i = 0; i < node_count; i++) {
   204					phandle = *data++;
   205	
   206					switch (action) {
   207					case OPCODE_DELETE:
   208						/* nothing to do */
   209						break;
   210					case OPCODE_UPDATE:
   211						update_node(phandle, scope);
   212						break;
   213					case OPCODE_ADD:
   214						/* nothing to do, just move pointer */
   215						drc_index = *data++;
   216						break;
   217					}
   218				}
   219			}
   220		} while (rc == 1);
   221	
   222		kfree(buf);
   223		return 0;
   224	}
   225	
   226	static int handle_image(struct cxl *adapter, int operation,
   227				long (*fct)(u64, u64, u64, u64 *),
   228				struct cxl_adapter_image *ai)
   229	{
   230		size_t mod, s_copy, len_chunk = 0;
   231		struct ai_header *header = NULL;
   232		unsigned int entries = 0, i;
   233		void *dest, *from;
   234		int rc = 0, need_header;
   235	
   236		/* base adapter image header */
   237		need_header = (ai->flags & CXL_AI_NEED_HEADER);
   238		if (need_header) {
   239			header = kzalloc(sizeof(struct ai_header), GFP_KERNEL);
   240			if (!header)
   241				return -ENOMEM;
 > 242			header->version = cpu_to_be16(1);
 > 243			header->vendor = cpu_to_be16(adapter->guest->vendor);
 > 244			header->device = cpu_to_be16(adapter->guest->device);
 > 245			header->subsystem_vendor = cpu_to_be16(adapter->guest->subsystem_vendor);
 > 246			header->subsystem = cpu_to_be16(adapter->guest->subsystem);
 > 247			header->image_offset = cpu_to_be64(CXL_AI_HEADER_SIZE);
 > 248			header->image_length = cpu_to_be64(ai->len_image);
   249		}
   250	
   251		/* number of entries in the list */
   252		len_chunk = ai->len_data;
   253		if (need_header)
   254			len_chunk += CXL_AI_HEADER_SIZE;
   255	
   256		entries = len_chunk / CXL_AI_BUFFER_SIZE;
   257		mod = len_chunk % CXL_AI_BUFFER_SIZE;
   258		if (mod)
   259			entries++;
   260	
   261		if (entries > CXL_AI_MAX_ENTRIES) {
   262			rc = -EINVAL;
   263			goto err;
   264		}
   265	
   266		/*          < -- MAX_CHUNK_SIZE = 4096 * 256 = 1048576 bytes -->
   267		 * chunk 0  ----------------------------------------------------
   268		 *          | header   |  data                                 |
   269		 *          ----------------------------------------------------
   270		 * chunk 1  ----------------------------------------------------
   271		 *          | data                                             |
   272		 *          ----------------------------------------------------
   273		 * ....
   274		 * chunk n  ----------------------------------------------------
   275		 *          | data                                             |
   276		 *          ----------------------------------------------------
   277		 */
   278		from = (void *) ai->data;
   279		for (i = 0; i < entries; i++) {
   280			dest = buffer[i];
   281			s_copy = CXL_AI_BUFFER_SIZE;
   282	
   283			if ((need_header) && (i == 0)) {
   284				/* add adapter image header */
   285				memcpy(buffer[i], header, sizeof(struct ai_header));
   286				s_copy = CXL_AI_BUFFER_SIZE - CXL_AI_HEADER_SIZE;
   287				dest += CXL_AI_HEADER_SIZE; /* image offset */
   288			}
   289			if ((i == (entries - 1)) && mod)
   290				s_copy = mod;
   291	
   292			/* copy data */
   293			if (copy_from_user(dest, from, s_copy))
   294				goto err;
   295	
   296			/* fill in the list */
   297			le[i].phys_addr = cpu_to_be64(virt_to_phys(buffer[i]));
   298			le[i].len = cpu_to_be64(CXL_AI_BUFFER_SIZE);
   299			if ((i == (entries - 1)) && mod)
   300				le[i].len = cpu_to_be64(mod);
   301			from += s_copy;
   302		}
   303		pr_devel("%s (op: %i, need header: %i, entries: %i, token: %#llx)\n",
   304			 __func__, operation, need_header, entries, continue_token);
   305	
   306		/*
   307		 * download/validate the adapter image to the coherent
   308		 * platform facility
   309		 */
   310		rc = fct(adapter->guest->handle, virt_to_phys(le), entries,
   311			&continue_token);
   312		if (rc == 0) /* success of download/validation operation */
   313			continue_token = 0;
   314	
   315	err:
   316		kfree(header);
   317	
   318		return rc;
   319	}
   320	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
