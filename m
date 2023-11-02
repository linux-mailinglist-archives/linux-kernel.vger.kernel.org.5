Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01C7DF59D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbjKBPEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjKBPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:04:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D99181;
        Thu,  2 Nov 2023 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937444; x=1730473444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cg9fqJR9fIKmGvrVxCoifHnJ6DMc/BhIrxzOVZ087yA=;
  b=YpPHOmi+bxNPNZEyNUugMzLT9EpEGtSo5a63N1CYDgUAc85Cf+Yqzuks
   HDKhGZIPm1OSq//733R2UuWgebH1jzifpwYFJOS1PTPosCGzyNflH4BJx
   MnH8Xi23D/RaTwirj8zjdJckIcZqi/ZGU6ML1jWKAkkdwzdj8yU987cCC
   /pGs/TLI7UxxxjTXjn5EyuOglN8/UrVxdwKCU90WlZy56Q+WaZnciBCk7
   hl0NKhzYk2v7NhoQHVp8B51xQ2NNo3WFlP8/x+qAl0M362o0Vig2HcCbA
   oaCXlU4euvIVz3OdASpYjE/6a1YPuqww2n89lbmBRs/iluihmqVwm1yKY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373770355"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="373770355"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="711170460"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711170460"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 08:03:46 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyZEW-0001Xq-21;
        Thu, 02 Nov 2023 15:03:44 +0000
Date:   Thu, 2 Nov 2023 23:03:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Stitt <justinstitt@google.com>,
        Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] scsi: libfc: replace deprecated strncpy with memcpy
Message-ID: <202311022256.mWiYJshd-lkp@intel.com>
References: <20231030-strncpy-drivers-scsi-libfc-fc_encode-h-v1-1-c08c2be6befa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030-strncpy-drivers-scsi-libfc-fc_encode-h-v1-1-c08c2be6befa@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ffc253263a1375a65fa6c9f62a893e9767fbebfa]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Stitt/scsi-libfc-replace-deprecated-strncpy-with-memcpy/20231031-063815
base:   ffc253263a1375a65fa6c9f62a893e9767fbebfa
patch link:    https://lore.kernel.org/r/20231030-strncpy-drivers-scsi-libfc-fc_encode-h-v1-1-c08c2be6befa%40google.com
patch subject: [PATCH] scsi: libfc: replace deprecated strncpy with memcpy
config: s390-defconfig (https://download.01.org/0day-ci/archive/20231102/202311022256.mWiYJshd-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311022256.mWiYJshd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311022256.mWiYJshd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'zfcp_fc_gspn',
       inlined from 'zfcp_fc_sym_name_update' at drivers/s390/scsi/zfcp_fc.c:951:8:
>> drivers/s390/scsi/zfcp_fc.c:877:15: warning: 'strstr' argument 1 declared attribute 'nonstring' [-Wstringop-overread]
     877 |             !(strstr(gspn_rsp->gspn.fp_name, devno)))
         |              ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/scsi/libfc.h:21,
                    from drivers/s390/scsi/zfcp_fc.c:19:
   include/uapi/scsi/fc/fc_ns.h: In function 'zfcp_fc_sym_name_update':
   include/uapi/scsi/fc/fc_ns.h:148:17: note: argument 'fp_name' declared here
     148 |         char    fp_name[] __nonstring;
         |                 ^~~~~~~


vim +877 drivers/s390/scsi/zfcp_fc.c

cc8c282963bd25 Swen Schillig    2008-06-10  844  
038d9446a9e601 Christof Schmitt 2011-02-22  845  static int zfcp_fc_gspn(struct zfcp_adapter *adapter,
038d9446a9e601 Christof Schmitt 2011-02-22  846  			struct zfcp_fc_req *fc_req)
038d9446a9e601 Christof Schmitt 2011-02-22  847  {
038d9446a9e601 Christof Schmitt 2011-02-22  848  	DECLARE_COMPLETION_ONSTACK(completion);
038d9446a9e601 Christof Schmitt 2011-02-22  849  	char devno[] = "DEVNO:";
038d9446a9e601 Christof Schmitt 2011-02-22  850  	struct zfcp_fsf_ct_els *ct_els = &fc_req->ct_els;
038d9446a9e601 Christof Schmitt 2011-02-22  851  	struct zfcp_fc_gspn_req *gspn_req = &fc_req->u.gspn.req;
038d9446a9e601 Christof Schmitt 2011-02-22  852  	struct zfcp_fc_gspn_rsp *gspn_rsp = &fc_req->u.gspn.rsp;
038d9446a9e601 Christof Schmitt 2011-02-22  853  	int ret;
038d9446a9e601 Christof Schmitt 2011-02-22  854  
038d9446a9e601 Christof Schmitt 2011-02-22  855  	zfcp_fc_ct_ns_init(&gspn_req->ct_hdr, FC_NS_GSPN_ID,
038d9446a9e601 Christof Schmitt 2011-02-22  856  			   FC_SYMBOLIC_NAME_SIZE);
038d9446a9e601 Christof Schmitt 2011-02-22  857  	hton24(gspn_req->gspn.fp_fid, fc_host_port_id(adapter->scsi_host));
038d9446a9e601 Christof Schmitt 2011-02-22  858  
038d9446a9e601 Christof Schmitt 2011-02-22  859  	sg_init_one(&fc_req->sg_req, gspn_req, sizeof(*gspn_req));
038d9446a9e601 Christof Schmitt 2011-02-22  860  	sg_init_one(&fc_req->sg_rsp, gspn_rsp, sizeof(*gspn_rsp));
038d9446a9e601 Christof Schmitt 2011-02-22  861  
038d9446a9e601 Christof Schmitt 2011-02-22  862  	ct_els->handler = zfcp_fc_complete;
038d9446a9e601 Christof Schmitt 2011-02-22  863  	ct_els->handler_data = &completion;
038d9446a9e601 Christof Schmitt 2011-02-22  864  	ct_els->req = &fc_req->sg_req;
038d9446a9e601 Christof Schmitt 2011-02-22  865  	ct_els->resp = &fc_req->sg_rsp;
038d9446a9e601 Christof Schmitt 2011-02-22  866  
038d9446a9e601 Christof Schmitt 2011-02-22  867  	ret = zfcp_fsf_send_ct(&adapter->gs->ds, ct_els, NULL,
038d9446a9e601 Christof Schmitt 2011-02-22  868  			       ZFCP_FC_CTELS_TMO);
038d9446a9e601 Christof Schmitt 2011-02-22  869  	if (ret)
038d9446a9e601 Christof Schmitt 2011-02-22  870  		return ret;
038d9446a9e601 Christof Schmitt 2011-02-22  871  
038d9446a9e601 Christof Schmitt 2011-02-22  872  	wait_for_completion(&completion);
038d9446a9e601 Christof Schmitt 2011-02-22  873  	if (ct_els->status)
038d9446a9e601 Christof Schmitt 2011-02-22  874  		return ct_els->status;
038d9446a9e601 Christof Schmitt 2011-02-22  875  
038d9446a9e601 Christof Schmitt 2011-02-22  876  	if (fc_host_port_type(adapter->scsi_host) == FC_PORTTYPE_NPIV &&
038d9446a9e601 Christof Schmitt 2011-02-22 @877  	    !(strstr(gspn_rsp->gspn.fp_name, devno)))
038d9446a9e601 Christof Schmitt 2011-02-22  878  		snprintf(fc_host_symbolic_name(adapter->scsi_host),
038d9446a9e601 Christof Schmitt 2011-02-22  879  			 FC_SYMBOLIC_NAME_SIZE, "%s%s %s NAME: %s",
038d9446a9e601 Christof Schmitt 2011-02-22  880  			 gspn_rsp->gspn.fp_name, devno,
038d9446a9e601 Christof Schmitt 2011-02-22  881  			 dev_name(&adapter->ccw_device->dev),
038d9446a9e601 Christof Schmitt 2011-02-22  882  			 init_utsname()->nodename);
038d9446a9e601 Christof Schmitt 2011-02-22  883  	else
820109fb11f24b Wolfram Sang     2022-08-18  884  		strscpy(fc_host_symbolic_name(adapter->scsi_host),
038d9446a9e601 Christof Schmitt 2011-02-22  885  			gspn_rsp->gspn.fp_name, FC_SYMBOLIC_NAME_SIZE);
038d9446a9e601 Christof Schmitt 2011-02-22  886  
038d9446a9e601 Christof Schmitt 2011-02-22  887  	return 0;
038d9446a9e601 Christof Schmitt 2011-02-22  888  }
038d9446a9e601 Christof Schmitt 2011-02-22  889  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
