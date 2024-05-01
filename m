Return-Path: <linux-kernel+bounces-165711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3C58B900B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F7B221D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B4161302;
	Wed,  1 May 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fuscnx88"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66212FB1A
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591728; cv=fail; b=IinCY2fuALAgjBPZfmIsR8jyQ7IPQ7x6Zs1MXYMA+D8TbMRDjfmSdD8TKCdyYClkyqPiyIFGDj0Nmo8Amx0b1q1JSc2KRX5/sYUC5c00cXrtze1b8MrYEPfcsQXRNpH+M+giWkdp7RJ/JoQeoZikqX3OSxZorBXrJprQD5j2NTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591728; c=relaxed/simple;
	bh=JX3bPSixXAN8llzH0r2IlD5+51eukb5MqgYOKhIBmZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aizEKTaqsoP5uenfJHT7zxQmoTr0EP4TnpeEkJi2HfcZ9MrYk5HtKpBoaeNr/Zqg0zGLbfeEdbj2ou2jK2ffGSUR9vG5mxnd/tFLxahV+9M9Dcq6gJs3W/PqbS6IFj1uR3XxEuz8fjSte8pLYkqeGDdKQZK+ZuYfd9y2L3aJO5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fuscnx88; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714591727; x=1746127727;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JX3bPSixXAN8llzH0r2IlD5+51eukb5MqgYOKhIBmZA=;
  b=Fuscnx88kNob/fc7GCrltMv1GsNpndubF97PJol3sdftODg6Fe6E2VHm
   DgaD8uHZGKP+Ws8/SZVQv7YgIq+Dv/jReePOgIRvONrL6HvnG+vK88IBY
   vsbW3kbMi1yBFDfnmVVFBspapzETMuwPk/ChIKJ3BaBy5LJFl6YJasS6y
   mjXD6cD7lOiRh3furQTkvQs6/VRUiO7qdeOEGp0yoNQJTBX3fCU80EDHK
   Ga5N3XcZuqFyQWbznlspkzNbZpcLjgxdVT+Mdi79HCQsdu1DbrWXZ8Wcq
   pOf0lqqZW4xxlFQxKhYCgxLVf3tJ3FzDYa0MwOva0ZMhyJsf3yPPmvne6
   Q==;
X-CSE-ConnectionGUID: XVMkdDkaT5KW3GxNuLMS4w==
X-CSE-MsgGUID: eiyNf8SiSUqPRW49rDSw6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="21754655"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="21754655"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 12:28:45 -0700
X-CSE-ConnectionGUID: Gs290JkURrqn/JpGlF4aug==
X-CSE-MsgGUID: 0BkjaitoTKGM1Iy/CstaoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="27378397"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 12:28:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 12:28:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 12:28:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 12:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/N67Ev3SQTLeRC8dQK7kRW3HWiI20JK7ST/lKuqbbkoHYurSN2EhggiX0TlUhFrRe9jZy7ecyXwnyzP8KhKlZuHsIliOKoXJmt944TCPh4wWRTNDBO/uXB5wbFyN23A6sUTWGd2ywrIF6NGkFrgqNOuJpBFVIgHYkINFFa3vJtbRRBLOFOSQX/DKZO+lIT/H1tpwcSUsNYGiWZ2JRJSUbOWEQ1013P0m4bwHbqf1TbnJMrm3kmDBKgrB2Y1w4+cyA7sP6N0Kdg1Ad6P1kafF+1zcNLVsN8+Q5ywjL1eOCQFtsOToMy7XL0NzVNts0sifArf2AstvV91Qx08LMcmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrI3OBHDLQaO6HyIF8SF6VCewk/bX3dTavWub3g6y+g=;
 b=U6+M93tqYqjYQbH2nflufrcqr3yoUBFins0GP8xthKaGfbUqXgQYxc4o7PZsgcxrk2BGx8k+RMZ9oRQIZWAF3cL/eG8CU+P7R8mcTFgq/Ju0Uc7BEZNU2b7oTMhGds/b+pjAbcv/8PZuo6R6I6CE/qyi4V8qKBDlwXcyDnbYxqbhG76tWArF6hMVZGHyTN6l9mj8VkhKPraJCoAitAbB17NbPzKVuBmmMBsuMVd8Bt5u1ZCW0kqUK6eB+HlDz47jOHhUvnCLRNa/KGdrImgJCYha+XmwmuKeQtH/RNenRLUijsPB9ZuVRGLGgM31qSre8icfPMrOa45Vy5nACjEIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 19:28:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 19:28:42 +0000
Date: Wed, 1 May 2024 12:28:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
	"Ashish Kalra" <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility
 support in TSM
Message-ID: <663297e7cbdee_1384629418@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
 <662c239680842_b6e02944b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f6af3a35-7ddd-7f56-d7d9-34c77647614d@amd.com>
 <33620512-a456-aa87-25d3-e15f2d3d256f@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33620512-a456-aa87-25d3-e15f2d3d256f@amd.com>
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cb1f40-c448-42ea-3d74-08dc6a14e93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?TkyCZdyu3siDOby+MigwXjGnYhGzNYLUQt76UoQJ6PwAbs8DDxsk7fLXUN?=
 =?iso-8859-1?Q?2JnNKfJl3tqjiiQj5T1ve7ssWkJMOyNZSWFLXIYVT3Htq5C9wvX/g6Woj9?=
 =?iso-8859-1?Q?AubWXCae4VqUrTBXQ8Are/Q9xcFmmfmS2+LuQVnQyLW40TLQE6d1lvirQc?=
 =?iso-8859-1?Q?Q5IjEGn2NZYaSkCancfTnWvnrfjFJcTQvVoXaTphFA/X2zTHPOh19xbt1T?=
 =?iso-8859-1?Q?rVVZ/bqEwAy5NJG/WDzzNIHODeQbMT4ByLEWzBYaZbsW+e+SbyXtUcrUyk?=
 =?iso-8859-1?Q?ZiMCCJZTQI78CLo4LkXB2H911MszX+NzSpveTHkcfFf7KhNohCh/nN2/o5?=
 =?iso-8859-1?Q?TqfS2Jju6dPFV/4OAU7+P+PNyhD4znS5oEBnQrBM+2GKXjmFsoodsJVoHe?=
 =?iso-8859-1?Q?CMquM9cBXR/qjqZv++Bo1PzOZcWiNkI9/Upw4JyhJL6yUTKD92A9pQgVX8?=
 =?iso-8859-1?Q?3znO4lEmbP87ZtcDDjAE7A7sFdbYjZ6Hx2XY/vwD0+arHRy/BhdIyNq9wD?=
 =?iso-8859-1?Q?xlqR3Wfs1AKHry86Wjr1P8/xDjojkat6F2HizmA0HWRyJ+dyFyf29YVVs7?=
 =?iso-8859-1?Q?qxOXPFBJ3nPwpcSGedZjrEhGaMCmDIPGF2M9YbOJYKBTsvH/l+/H4j6Z4v?=
 =?iso-8859-1?Q?5Ih4TdmpwNckXwg7QxDzz7kLTI798cn1EpVYM09fk0N1+nddiL+WUFvXgf?=
 =?iso-8859-1?Q?JjflKsMgtq1Ehxlj5VHSjkiGYrXP/bU39sWwpBHzBIO0PJU9y+mdpA6vhD?=
 =?iso-8859-1?Q?ho3P9CJnRufaojUe7B//ix9rgbrq6I4CPZY4hEEUByNpj3dQpxS14E4k6c?=
 =?iso-8859-1?Q?4WJcInQ7MZztO0pJwxHnU88vIPc7mV3Ku1xAcRlBecUIQddrdPdHsX3LYy?=
 =?iso-8859-1?Q?DXtynWQypIjQPCjSaefZwoX1cXGQFrr3M2KZ5/4o9nSlcwgcs59/tH8TqX?=
 =?iso-8859-1?Q?NgAul/rUCSNHeXEnxzJcoEvHtOJer/M/eJFqLwPLpI+cQcHQA5LzVu6xxp?=
 =?iso-8859-1?Q?gpHkxlrkA0BxnHboz1d8iG7byAc1M8F1xqMRvhIsq3jF9L96wHgfmkCTIk?=
 =?iso-8859-1?Q?hdF6E1ALX+GNkoniSGPbNkZ6DEiS54vpo6NZLXbJx8ssAOMNxW2XtP3mcx?=
 =?iso-8859-1?Q?orMNUgxddNAvfEn6re2tH6NWLwQy3ZslWyblp2EZS7RSaQEvH7pJAAe3wZ?=
 =?iso-8859-1?Q?KgZSHp8M6aY1xBLlOBRhrS33mJgT2D9bImvBxL87QEBtVdMIwpUwmPbFtA?=
 =?iso-8859-1?Q?5h/9RSQa9xvYT3dBLhfOcGsJ7rDnzj1snjKTV1u2RQ1whAuLSFdM1pJg6a?=
 =?iso-8859-1?Q?hm7G8U8ksesSQXYNl0mLPAPugQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?c+JPi0/MUFh8tryxgKyC66VjULkClVQy5MTCIVavVnOb5gnWR93r/K1eFr?=
 =?iso-8859-1?Q?ev28lZx+1Bp5S51iYbwHnZkSFqb168VDAHURItk+tA9kdoXZhoWTA2Zq+0?=
 =?iso-8859-1?Q?RwUS7stUG3PUjj/s9cLm3CaTjzrUmK/H8Y27TxSVim8YuzHauDLq5XKDXC?=
 =?iso-8859-1?Q?gHQJp3h56pYdW+dtCQfw1E5GKm8pPk87P7Kx0IoeWjyFR5dlNzUXvKpOEE?=
 =?iso-8859-1?Q?FpcYCDYqQzyFzToHg8J6a4tbKYXhxZb9wVPl3Yzww1gZadx/V5dXX8ROOK?=
 =?iso-8859-1?Q?9NwN4n5459xern2IilI8Vq0XArC5vNtY0mIwk5psVQx3YfLYIWGOSlUW3O?=
 =?iso-8859-1?Q?cxMjWiGVYy2LJWVTmypc4dHV4ulZkZIICGgHVc/4VQB3pSzPSbSOolG0YK?=
 =?iso-8859-1?Q?zCH95oxRqfVACi6CZ2XZsav0t8v7OaQynqRY1He0VFy5FqBWdElHXRnOcK?=
 =?iso-8859-1?Q?HLeZ1mlbfRYj56cbkXxIqwCif6GF2WTB3K06tJ4tWQshpemZKa23l3uRqA?=
 =?iso-8859-1?Q?+T6zs6IzRp5x/L9l/cqmkQYi3V5u3SfbRrAI/vH26a2FiddAuqFOekcb6s?=
 =?iso-8859-1?Q?t9XHOqrRdqwVVLUtEgm8hkkSTMsuhA2wBj9WaHzV8FIBpthFe6jdUamCgq?=
 =?iso-8859-1?Q?5CmWc6FSwXeCLF5gs60SUK+hgyH2CEGC9TN6mQZpUFjVju1DH7HrWQ/klm?=
 =?iso-8859-1?Q?DmhGeQOZiU6GnffvA3+xw6SRsXT6AHUns+N/VWKROVNBSIjWAyTau8hQI1?=
 =?iso-8859-1?Q?IzF2QvD2/fs9D/5HWNnUm1KIeJedUrhl7mH1qXdy9YA3UanTLHDt5ea4zZ?=
 =?iso-8859-1?Q?qUda6sFzak6JnMRvGJD+YwXguIrz9wr97lUE+4XRDnvGZX30geE67pOc7N?=
 =?iso-8859-1?Q?Hte8TzOIzKyr2KLgsc+UzIS3DeG2BjNv7YJutZcCq+LSi5+3s+WexhU6Xh?=
 =?iso-8859-1?Q?BP/nkuFdscxCJaGX6++KpFp18L0LOHU93EFC5yBM+AS9wBSRMJr5DWagAX?=
 =?iso-8859-1?Q?n7y1GYFKWq9rMqzMhGSDQgfl+z5CJKoy4WWgP3m+TzdILF/SWDAB504cI+?=
 =?iso-8859-1?Q?jHVCGBTqjZt8p6MFufKYvpFFY/4NbeML3NzcVoigmMRZh3OzIkxV9CM8HC?=
 =?iso-8859-1?Q?ZBa7sBIFVNU8++RvlhAFUdORiMaitEHRT6Yo/agZ/liCZeCJUmd/wm3RqE?=
 =?iso-8859-1?Q?dAiItZ8VmEBEY4zvIXyUTG0A0y5ZRcf83ooDe/gXyFOAjT+FJ+lyEI7dFu?=
 =?iso-8859-1?Q?wpAQtnCaOwI3vDxHOhEWxHFletJWL0gajr2UW0lkDsvoUnzW8pu1FwNVJX?=
 =?iso-8859-1?Q?zoyjNwLyxw+U0oZfkJjucrsZeKXOGnsfeHV4x9WH7Ef0b5nlg9keM532eI?=
 =?iso-8859-1?Q?DDD56LXgNJpc3abkW+9nzsKtikGWjLCcap2vQ9SihYPU3zezKiJm9gV1Wx?=
 =?iso-8859-1?Q?FDSDAQL0Rh0Z6B9QGLsswznPCLVefkYXJnshZumFjXsG0XG0XtE6KVA5Yz?=
 =?iso-8859-1?Q?IhfAntXnZaORu3rn0XzYD2RxojoJQ0sOEd+zZVYva9z827M8ql0QXF7fbr?=
 =?iso-8859-1?Q?6bfOWKfn672kAheHIkYmv08MwGlyXBRi25veLeZK8UYfPf9W97Uhhlc/2a?=
 =?iso-8859-1?Q?dHe8bs0YhtxkzKY2K0f5qv8WpJkL90KaAyOybkkJL0A6hqYWCAh5hoRQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cb1f40-c448-42ea-3d74-08dc6a14e93f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 19:28:42.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaf5tduUmCmEwyjl2B+4xEBtlTZ+Zrnl5lC1uF9n4lNbYpFDEGdC9y6adaroOJAOTqc/ju6wXXqVQ+xELQwo7lYbe+IGfQOmsEYYCBcvDbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
[..]
> >>> +static bool tsm_report_is_visible(struct config_item *item,
> >>> +                  struct configfs_attribute *attr, int n)
> >>
> >> Per the comment on where to find the is_visible() callbacks for a given
> >> item type, I expect the need to pass @item here goes away when this can
> >> assume that there is only one way to have is_visible() invoked for
> >> @attr, right?
> > 
> > Yes.
> 
> But as I look closer, there is only a single ops callback pair 
> (is_visible() and is_bin_visible()), so as long there is never another 
> group / subdir defined under the TSM report, this works. But if another 
> group is added, then the item parameter would likely be needed or the 
> ops callback would have to be updated to differentiate for the vendor 
> (SNP/TDX).

Makes sense, for the tsm_report_is_visible() signature. Especially as
this is proposed as a generic configfs facility. It has symmetry with
sysfs that passes an @kobj parent anchor, to sysfs is_visible()
callbacks.

However, I still think neither @item nor @attr need to be passed down
from tsm_report_is_visible() to the vendor backend. Those can be added
when/if another item type is added, which I do not see on the horizon.

