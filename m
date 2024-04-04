Return-Path: <linux-kernel+bounces-130826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B6897D91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F8D285B07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347419470;
	Thu,  4 Apr 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqcqdNso"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453813FC2;
	Thu,  4 Apr 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196147; cv=none; b=SICcWifR3nbVmnLkfUC0Ddf+bkm8p+t7WqvvAkKffTxaM8HD0kVUjVWRvz+W9UTHKH+PPngrkabC7Us4m88nS5l/YMNey/XX2YQi4Je4UT8ob2zab385uh287zQrrN5KeMwKrpoSe5/AWVO15g0e0wYSE4GQ2cZD/KG92kCc7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196147; c=relaxed/simple;
	bh=DUWHamg1uniKlSSBNG+c78Cu/IUUW7khihSA7S/VgtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYzOYtysWcvD616Ag9can/Xldvucv5cJXkGYVRt0wPzeCTVZUpnHXI+pOXbAqy0jslX4I1DncZ9GzrRQAmGohevCSwG0JH3Y3Bb177Nx2xFj66+xzcnKiFIQ3IIfaGFKGxYE2GSWm8Bp997l5W40QxXtn/nXsRb4wYup3sy8rm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqcqdNso; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712196145; x=1743732145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DUWHamg1uniKlSSBNG+c78Cu/IUUW7khihSA7S/VgtE=;
  b=ZqcqdNso48OI5q9oALAR+1zEJ5+KCmnpc5gqeH5m3EBGDwefnEpy2ZK5
   5aJX46+NeLlktCfmXMyeTmBwL1QgJ6tFOTKkAfHC8+GDvxRYXtcoEnFeA
   Y2R9hHzwsr8zCZnGs8d5mPKssHHM4/GEtjpCzziBT7hpdWJzrGGtZZAZu
   SmBMAW53JgXOQA0DbFgYZbLj0CT6ZrJScSqvWuREN+7qg/Jzy0t5tOLnA
   0Ex8IZALQgdl80Exlj9hQF2qiKnEChI6WPVe36LcEnsEG/ERnZTTfIN/X
   EsyEAtQpIhSQvdQQWzvSDjl6uvzV9vShrgidxe2I5bByr3LefkMOHB8wY
   g==;
X-CSE-ConnectionGUID: Z8hsy3lERoqB6hTm0lErRw==
X-CSE-MsgGUID: gf2m0v/dQ0OdK9TbtjSdQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11289966"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="11289966"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 19:02:24 -0700
X-CSE-ConnectionGUID: B35+lIb8S9+8XOEzA3rZAQ==
X-CSE-MsgGUID: 8qmKPmsGSkehc2XgYSBgZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18477636"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Apr 2024 19:02:22 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsCQk-0000TO-30;
	Thu, 04 Apr 2024 02:02:18 +0000
Date: Thu, 4 Apr 2024 10:01:17 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
	cristian.marussi@arm.com, jassisinghbrar@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
Message-ID: <202404040918.E8nkWuIn-lkp@intel.com>
References: <20240403171346.3173843-2-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403171346.3173843-2-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on robh/for-next linus/master v6.9-rc2 next-20240403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/dt-bindings-mailbox-arm-mhuv3-Add-bindings/20240404-012010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240403171346.3173843-2-cristian.marussi%40arm.com
patch subject: [PATCH v2 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240404/202404040918.E8nkWuIn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404040918.E8nkWuIn-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml:86:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
--
>> Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml:86:1: found a tab character where an indentation space is expected
--
>> Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml: ignoring, error parsing file

vim +86 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml

     8	
     9	maintainers:
    10	  - Sudeep Holla <sudeep.holla@arm.com>
    11	  - Cristian Marussi <cristian.marussi@arm.com>
    12	
    13	description: |
    14	  The Arm Message Handling Unit (MHU) Version 3 is a mailbox controller that
    15	  enables unidirectional communications with remote processors through various
    16	  possible transport protocols.
    17	  The controller can optionally support a varying number of extensions that, in
    18	  turn, enable different kinds of transport to be used for communication.
    19	  Number, type and characteristics of each supported extension can be discovered
    20	  dynamically at runtime.
    21	
    22	  Given the unidirectional nature of the controller, an MHUv3 mailbox controller
    23	  is composed of a MHU Sender (MHUS) containing a PostBox (PBX) block and a MHU
    24	  Receiver (MHUR) containing a MailBox (MBX) block, where
    25	
    26	   PBX is used to
    27	      - Configure the MHU
    28	      - Send Transfers to the Receiver
    29	      - Optionally receive acknowledgment of a Transfer from the Receiver
    30	
    31	   MBX is used to
    32	      - Configure the MHU
    33	      - Receive Transfers from the Sender
    34	      - Optionally acknowledge Transfers sent by the Sender
    35	
    36	  Both PBX and MBX need to be present and defined in the DT description if you
    37	  need to establish a bidirectional communication, since you will have to
    38	  acquire two distinct unidirectional channels, one for each block.
    39	
    40	  As a consequence both blocks needs to be represented separately and specified
    41	  as distinct DT nodes in order to properly describe their resources.
    42	
    43	  Note that, though, thanks to the runtime discoverability, there is no need to
    44	  identify the type of blocks with distinct compatibles.
    45	
    46	  Following are the MHUv3 possible extensions.
    47	
    48	  - Doorbell Extension (DBE): DBE defines a type of channel called a Doorbell
    49	    Channel (DBCH). DBCH enables a single bit Transfer to be sent from the
    50	    Sender to Receiver. The Transfer indicates that an event has occurred.
    51	    When DBE is implemented, the number of DBCHs that an implementation of the
    52	    MHU can support is between 1 and 128, numbered starting from 0 in ascending
    53	    order and discoverable at run-time.
    54	    Each DBCH contains 32 individual fields, referred to as flags, each of which
    55	    can be used independently. It is possible for the Sender to send multiple
    56	    Transfers at once using a single DBCH, so long as each Transfer uses
    57	    a different flag in the DBCH.
    58	    Optionally, data may be transmitted through an out-of-band shared memory
    59	    region, wherein the MHU Doorbell is used strictly as an interrupt generation
    60	    mechanism, but this is out of the scope of these bindings.
    61	
    62	  - FastChannel Extension (FCE): FCE defines a type of channel called a Fast
    63	    Channel (FCH). FCH is intended for lower overhead communication between
    64	    Sender and Receiver at the expense of determinism. An FCH allows the Sender
    65	    to update the channel value at any time, regardless of whether the previous
    66	    value has been seen by the Receiver. When the Receiver reads the channel's
    67	    content it gets the last value written to the channel.
    68	    FCH is considered lossy in nature, and means that the Sender has no way of
    69	    knowing if, or when, the Receiver will act on the Transfer.
    70	    FCHs are expected to behave as RAM which generates interrupts when writes
    71	    occur to the locations within the RAM.
    72	    When FCE is implemented, the number of FCHs that an implementation of the
    73	    MHU can support is between 1-1024, if the FastChannel word-size is 32-bits,
    74	    or between 1-512, when the FastChannel word-size is 64-bits.
    75	    FCHs are numbered from 0 in ascending order.
    76	    Note that the number of FCHs and the word-size are implementation defined,
    77	    not configurable but discoverable at run-time.
    78	    Optionally, data may be transmitted through an out-of-band shared memory
    79	    region, wherein the MHU FastChannel is used as an interrupt generation
    80	    mechanism which carries also a pointer to such out-of-band data, but this
    81	    is out of the scope of these bindings.
    82	
    83	  - FIFO Extension (FE): FE defines a Channel type called a FIFO Channel (FFCH).
    84	    FFCH allows a Sender to send
    85	       - Multiple Transfers to the Receiver without having to wait for the
  > 86		 previous Transfer to be acknowledged by the Receiver, as long as the
    87		 FIFO has room for the Transfer.
    88	       - Transfers which require the Receiver to provide acknowledgment.
    89	       - Transfers which have in-band payload.
    90	    In all cases, the data is guaranteed to be observed by the Receiver in the
    91	    same order which the Sender sent it.
    92	    When FE is implemented, the number of FFCHs that an implementation of the
    93	    MHU can support is between 1 and 64, numbered starting from 0 in ascending
    94	    order. The number of FFCHs, their depth (same for all implemented FFCHs) and
    95	    the access-granularity are implementation defined, not configurable but
    96	    discoverable at run-time.
    97	    Optionally, additional data may be transmitted through an out-of-band shared
    98	    memory region, wherein the MHU FIFO is used to transmit, in order, a small
    99	    part of the payload (like a header) and a reference to the shared memory
   100	    area holding the remaining, bigger, chunk of the payload, but this is out of
   101	    the scope of these bindings.
   102	
   103	properties:
   104	  compatible:
   105	    const: arm,mhuv3
   106	
   107	  reg:
   108	    maxItems: 1
   109	
   110	  interrupts:
   111	    minItems: 1
   112	    maxItems: 74
   113	
   114	  interrupt-names:
   115	    description: |
   116	      The MHUv3 controller generates a number of events some of which are used
   117	      to generate interrupts; as a consequence it can expose a varying number of
   118	      optional PBX/MBX interrupts, representing the events generated during the
   119	      operation of the various transport protocols associated with different
   120	      extensions. All interrupts of the MHU are level-sensitive.
   121	      Some of these optional interrupts are defined per-channel, where the
   122	      number of channels effectively available is implementation defined and
   123	      run-time discoverable.
   124	      In the following names are enumerated using patterns, with per-channel
   125	      interrupts implicitly capped at the maximum channels allowed by the
   126	      specification for each extension type.
   127	      For the sake of simplicity maxItems is anyway capped to a most plausible
   128	      number, assuming way less channels would be implemented than actually
   129	      possible.
   130	
   131	      The only mandatory interrupts on the MHU are:
   132	        - combined
   133	        - mbx-fch-xfer-<N> but only if mbx-fcgrp-xfer-<N> is not implemented.
   134	
   135	    minItems: 1
   136	    maxItems: 74
   137	    items:
   138	      oneOf:
   139	        - const: combined
   140	          description: PBX/MBX Combined interrupt
   141	        - const: combined-ffch
   142	          description: PBX/MBX FIFO Combined interrupt
   143	        - pattern: '^ffch-low-tide-[0-9]+$'
   144	          description: PBX/MBX FIFO Channel <N> Low Tide interrupt
   145	        - pattern: '^ffch-high-tide-[0-9]+$'
   146	          description: PBX/MBX FIFO Channel <N> High Tide interrupt
   147	        - pattern: '^ffch-flush-[0-9]+$'
   148	          description: PBX/MBX FIFO Channel <N> Flush interrupt
   149	        - pattern: '^mbx-dbch-xfer-[0-9]+$'
   150	          description: MBX Doorbell Channel <N> Transfer interrupt
   151	        - pattern: '^mbx-fch-xfer-[0-9]+$'
   152	          description: MBX FastChannel <N> Transfer interrupt
   153	        - pattern: '^mbx-fchgrp-xfer-[0-9]+$'
   154	          description: MBX FastChannel <N> Group Transfer interrupt
   155	        - pattern: '^mbx-ffch-xfer-[0-9]+$'
   156	          description: MBX FIFO Channel <N> Transfer interrupt
   157	        - pattern: '^pbx-dbch-xfer-ack-[0-9]+$'
   158	          description: PBX Doorbell Channel <N> Transfer Ack interrupt
   159	        - pattern: '^pbx-ffch-xfer-ack-[0-9]+$'
   160	          description: PBX FIFO Channel <N> Transfer Ack interrupt
   161	
   162	  '#mbox-cells':
   163	    description: |
   164	      The first argument in the consumers 'mboxes' property represents the
   165	      extension type, the second is for the channel number while the third
   166	      depends on extension type.
   167	
   168	      Extension type for DBE is 0 and the third parameter represents the
   169	      doorbell flag number to use.
   170	      Extension type for FCE is 1, third parameter unused.
   171	      Extension type for FE is 2, third parameter unused.
   172	
   173	      mboxes = <&mhu 0 0 5>; // DBE, Doorbell Channel Window 0, doorbell flag 5.
   174	      mboxes = <&mhu 0 1 7>; // DBE, Doorbell Channel Window 1, doorbell flag 7.
   175	      mboxes = <&mhu 1 0 0>; // FCE, FastChannel Window 0.
   176	      mboxes = <&mhu 1 3 0>; // FCE, FastChannel Window 3.
   177	      mboxes = <&mhu 2 1 0>; // FE, FIFO Channel Window 1.
   178	      mboxes = <&mhu 2 7 0>; // FE, FIFO Channel Window 7.
   179	    const: 3
   180	
   181	  clocks:
   182	    maxItems: 1
   183	
   184	required:
   185	  - compatible
   186	  - reg
   187	  - interrupts
   188	  - interrupt-names
   189	  - '#mbox-cells'
   190	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

