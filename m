Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4737ED80C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbjKOXUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjKOXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:20:47 -0500
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98A1195;
        Wed, 15 Nov 2023 15:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3794; q=dns/txt; s=iport;
  t=1700090443; x=1701300043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s4wtEACPpGzLl+CAEOnVZVms4bw/B+5gG+dUpz5JSfk=;
  b=eW6ICW0qF47fgLDPkrcbIujgaJnOh4Xldofiar0bNHiu0k2t3zRSJ4K6
   /SXR/Yt6NdAX5uBcQ/ksyEKO7/KeTLl7Yo//QAipV0PBepilNu5a/ZP9P
   WP+sGa2ta2sqIwh4BWSjgZ7RY+dmkhmDKSNhaY46c2AzQpQz25QaZ0sdw
   8=;
X-CSE-ConnectionGUID: cIxO5PgpT7eqstawkX9tVA==
X-CSE-MsgGUID: BbAO2TVbSfmlaqZRc88F4Q==
X-IPAS-Result: =?us-ascii?q?A0AJAAD0UVVlmIgNJK1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgRYGAQEBCwGBZlJ4WzxIhFKDTAOETl+GQYIiA51+gSUDVg8BAQENA?=
 =?us-ascii?q?QFEBAEBhQYCFocSAiY0CQ4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHB?=
 =?us-ascii?q?BQBAQEBAQEBAR4ZBRAOJ4VoDQiGPQEBAQECARIRBA0MAQE3AQQLAgEIGAICJ?=
 =?us-ascii?q?gICAjAVEAIEAQ0FCBqCXoI8IwMBoSwBgUACiih6fzOBAYIJAQEGBAWybQmBG?=
 =?us-ascii?q?i4BiAwBgVCIPicbgg2BFUKCaD6CYQKBYhWDRDmCL4NvhToHMoIigykpgROMe?=
 =?us-ascii?q?wl2R3AbAwcDfw8rBwQtGwcGCRQtIwZRBCgkCRMSPgSBY4FRCn8/Dw4RgkAiA?=
 =?us-ascii?q?gc2NhlIglsVDDRKdhAqBBQXgREEagUWFR43ERIXDQMIdB0CESM8AwUDBDMKE?=
 =?us-ascii?q?g0LIQUUQgNCBkkLAwIaBQMDBIE2BQ0eAhAaBg0nAwMTTQIQFAM7AwMGAwsxA?=
 =?us-ascii?q?zBVRAxQA2sfNgk8CwQMHwIbHg0nKAIyQgMRBRICFgMkGQQ2EQkLLQMoA0QdQ?=
 =?us-ascii?q?AMLbT01FBsFBDspWQWjFhmBG0BBDwEpliBJmUqTPIEuCoQNoT8XqgQumBIgo?=
 =?us-ascii?q?nSFFwIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OIAwNCYNWj3l2AjkCBwsBAQMJi?=
 =?us-ascii?q?mEBAQ?=
IronPort-PHdr: A9a23:2RhHERBdoxN1ZVkzlXEuUyQVoBdPi9zP1kY9454jjfdJaqu8us2kN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+iLzKlBbTf73fEaauXiu9XgXExT7OxByI7H2E5TOjsC+1Mi5+obYZENDgz/uKb93J
 Q+9+B3YrdJewZM3M7s40BLPvnpOdqxaxHg9I1WVkle06pK7/YVo9GJbvPdJyg==
IronPort-Data: A9a23:Akx0Mqp1u0KN9aY868IlF8PncdxeBmLQZRIvgKrLsJaIsI4StFCzt
 garIBmEM/aOamXzKNskbtngoxlXuZ6By9JjQVM5/ylgQSISoOPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7wdOCn9T8ljf3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYATNNwJcaDpOsPva8U434JwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86rIGaRpz6xE78FU7tJo56jGqE4aue60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/yxWZcV7FLH7zXeXuu2D6BD+fGPQnPh3F10/Io4oq/pJKDQbn
 RAYAGhlghGrjuayxvewTfNhw59lJ8jwN4RZsXZlpd3bJa95GtaYHeOTvpkBh2lYasNmRZ4yY
 +IaYCBzbRDJYDVEO0wcD9Q1m+LAanzXKmYJ8wLM+Ptri4TV5CZ7+Z+3DOTfQdKPQcxMrHyT9
 jLoo12sV3n2M/TGmWbarRpAnNTnmSL9RZJXF7Ci8PNuqEOcy3ZVCxAMU1a/5/6jhSaWX9NZN
 lxR4SE1rIAs+0GxCNrwRRu1pDiDpBF0ZjZLO+Q+7AfIwa3O7kPCQGMFVTVGLtchsafaWADGy
 HeCvsPOWARgqIHKRGuG6r6LrgPjJRY8eDpqiTA/cSMJ5NzqoYcWhx3JT8p+HKPdsjETMWyuq
 9xthHVj74j/nfLnxI3gpgme3GzESozhC19ruFqGBwpJ+ysjPOaYi5qUBU83BBqqBK+dSlSH1
 JTvs5fDtLlVZX1hedDkfQngNLit4/DAOzrGjBs0WZIg7D+qvXWkeOi8AQ2Sxm83aa7omhewP
 Sc/XD+9ArcIYxNGiocsM+qM5zwCl/SIKDgcfqm8giBySpZwbhSb2ypleFSd2Wvg+GB1zvlnY
 cjAKZ3xUSdKYUiC8NZQb7lFuVPM7n5mrV4/ubinp/ha+ePEPSXMGett3KWmNLBltctoXzk5A
 /4GZ5fVlH2zocX1YzLc9sYIPEsWIH0gba0aWOQJHtNv1jFOQTl7Y9eImOtJU9U8z8x9yLySl
 lnjARAw9bYKrSCdQel8Qio9OOqHsFcWhS9TABHAyn7yhyZ7ONv1tPh3mlleVeBPydGPBMVcF
 pEtU86BGf9IDD/A/lwggVPV9dEKmMiD7e5WAxeYXQ==
IronPort-HdrOrdr: A9a23:5jdQia98wUspmipjG95uk+Gddr1zdoMgy1knxilNoENuA6+lfp
 GV/MjziyWUtN9IYgBQpTnhAsW9qXO1z+8N3WBjB8bTYOCAghrnEGgC1/qs/9SEIVydygcz79
 YcT0ETMqyWMbE+t7eF3ODaKadg/DDkytHVuQ629R4EJm8aDtAF0+46MHflLqQcfng/OXNNLu
 vn2iMxnUvaRZ14VLXcOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jAR4J/Nj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVIQdS5zXMIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6kXl1USTjRLY0I7ErXMBeo98bLBiA1zkAnkbzZdBOW
 VwrjukXq9sfFf9deLGloD1vl9R5xGJSDEZ4J0uZjRkIPkjgflq3MwiFIc/KuZcIMo8g7pXSt
 VGHYXS4u1bfkidaG2ctm5zwMa0VnB2BRueRFMe0/blmQS+sUoJh3fw/vZv1Uso5dY4Ud1J9u
 7EOqNnmPVHSdIXd7t0AKMETdGsAmLATBrQOCbKSG6XWJ0vKjbIsdr68b817OaldNgBy4Yzgo
 3IVBdduXQpc0zjBMWS1NlA8wzLQm+6QTPxo/suqqRRq/n5Xv7mICeDQFchn4+ppOgeGNTSX7
 KpNJdfE5bYXCLT8EZyrnvDsrVpWA4juZcuy6MGsnq107b2FrE=
X-Talos-CUID: 9a23:rNuRbWwLZtwxrxqubwijBgUfO9ACL0XS1EuPLlajFW92S43EVWG5rfY=
X-Talos-MUID: 9a23:Dk4MLgpHde3V3XCPL7YezxtoHeAy35qkM04IlZwfifOPZXxeZw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:20:28 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 3AFNKSEh022234
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 23:20:28 GMT
X-CSE-ConnectionGUID: jkLMscBmTC63l0Sp7XER2Q==
X-CSE-MsgGUID: Q1Vl0wK6R9adRvjKHri6KA==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,306,1694736000"; 
   d="scan'208";a="8342043"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:20:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAOpXhUD5Y9Om2nwx52vNiwKwObJmO2e/BD/I+NCCizFIue2kjHo1EZrbmrUIxXJ7EPDWjolXv65s6iKa4kBSu2yu55dXHYkcsFoFYfy/203EZ/hk0Q7XzhBk2O7eD8YRHF5YEbgpWOcGT5qyOGL/I6qE4D2pYKvXu5idaRSGLshBA616/WFvR3xQ+fuD5Z7D8s4CHRptpfaLxAiy/ORrcMv9nbpFT/bojggchJfAoi7pohD83SXXgZ90W8Kwk1jZaZYYsPxSotbUJ4P4olaW7XlZ3q4IC+UQbVqMwydcw8dU23tak1JmhCW225YJi4mITNTfYEqAfdjCdy2Cu01Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4wtEACPpGzLl+CAEOnVZVms4bw/B+5gG+dUpz5JSfk=;
 b=nblrhKKctaibRwBTtcQDL4Ytyo9l9Dz8VwqY0TZRei18ygc4+ZSpQ/aK+7bcyR96GDkPNIReSi79ClMxAw4b8ZeMJd3FjTLX+ks5XUZXoBci9HaHlhi1gsDCad9KAqLtE8xR09/J0AdIOv3OS9BAmddkNzVmaRa4jcfi4lIoWXLUvclX4/bumEs2AGK++mYyUTyc5hHhu6D4ccPDIGiJzah/p/VgpcTQ4tpb2gjrtsk3qkpXCnvlw3az2rVMSY54J7Zfy5Y3DDU9W3dUHdu29cab4aFhvtMBkZq0Qz4SJHGl5acTOXtv/wJs3krsrll0nMIGG9zYIXwmmp2OWJ+3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4wtEACPpGzLl+CAEOnVZVms4bw/B+5gG+dUpz5JSfk=;
 b=N5jlFM8S5TnR6PEynXuM45gsTJk0mASksS1zszmxrPoWGmSE2G+STdn17PelWHp+ml400Sx7tFdnScA6bcZ58vBknxblBiSq2oJ16L5xuuhUvJLw/t1gaPjErjS/uiCaW5ofY2FE0I2pjgJkindPhkKntHM7wG8kidBTAZGckNU=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 23:20:26 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 23:20:26 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     John Garry <john.g.garry@oracle.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCH v3 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
Thread-Topic: [PATCH v3 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
Thread-Index: AQHaF0tJQV9WC9tGUUarC1O77Noe2LB7e1CAgACIBDA=
Date:   Wed, 15 Nov 2023 23:20:26 +0000
Message-ID: <SJ0PR11MB5896F9B7FA37D78B91BB1D42C3B1A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231114223810.634200-1-kartilak@cisco.com>
 <09b84161-748b-c1c2-e4e8-96df5d2b01e5@oracle.com>
In-Reply-To: <09b84161-748b-c1c2-e4e8-96df5d2b01e5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|SJ2PR11MB8348:EE_
x-ms-office365-filtering-correlation-id: d6b7f65e-458c-48cf-6121-08dbe6317317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GP7Ty1bkL21bBGcpeCp1YMRWdhJI12UNqjQXoaezq0t9N+cOlmW1AM9gi6NQ3WhygIMKSN/xRif7VmGRrrYZRxtpPeGNCzrg60ZL6yAvGFcf1YppMCwaqch2CYDCcmqrkBFdYq3+WY2ffmX6Lv4NjMF/BAB8X1vIMbf4Rrw/BBQS7baLv5X+UZSeN8fyHv1zH6DGkdzIFHiePBQs1wRnKyDY4GIyBnbEFgKAk8mLuBmCxNdh/cmIU1+2XUJJLkqCpXUNKaAomnDiiixAe3oi6djzBrwjIkUZdTHEjjMv7w2/QZc3zNFlr3hYg4untARRDS2kBQNs2iMVJToFeqJn+jcJiVNDbwWfXh0Mjsc4fUkWYpA1cVnP+nrPKwZToZW7tboGJtNfBX8em4EsV5weRV/ogX2y0pUsOONCPIm0+Ys/65MnhmQNBKG+khyOB1iKuIeGr4JO0ejdP6oPEnlWoUSBbuVtVcgV2zv/yUvcHwf9ALtI+wtLklL9d6ivCoxAuT4jPtPEj1ylglKpyDWy0ljFc0Zg2NH6DNrxy13c26yEEeUGeGuw5awD3Wi5GATXVujf3kkwFsi1Z+qND3X/b4pdDaJ3Up3GCgoDzyh7u34PXwfw5XTIk4LHVMETBfjZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(122000001)(38070700009)(55016003)(86362001)(2906002)(6506007)(71200400001)(110136005)(478600001)(38100700002)(53546011)(7696005)(9686003)(41300700001)(33656002)(52536014)(8936002)(66556008)(5660300002)(76116006)(6636002)(66446008)(316002)(66946007)(64756008)(4326008)(8676002)(66476007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGVOZXNzK2RzT0pQVUczUGcyakc5c1pya2VnQmx2M25sMVp6ZE9ZanF0ZStZ?=
 =?utf-8?B?U1BtV2dEeGFxZHBOMTBmMFpHaUZyNWdqL0VsYkhhTTJoK2lGWnBqanFuaFBZ?=
 =?utf-8?B?ZW85ejByaUNCaE9vYnp1dWVFa2xVSUZUTitjdmNCV1o5TGw5elYwWWdUV0dM?=
 =?utf-8?B?WmwxV2RaM2t4bThldW42dktWc1dFMnV5WGNBWWlTc3hSeXYxL1l5Z3ZPZ2tF?=
 =?utf-8?B?OTZNQVhZdnJkSXpsVzU5cDIraHQranNKbjZMcGJ0cE8yZG4rZmZUZytwci9D?=
 =?utf-8?B?aEw5MHUrVGdWRWZrZVUveUt0NG1kaUY0WHZCUUhtMG5BSzFLdWsrUjMxT0tB?=
 =?utf-8?B?cjliODFrWDZqVDVkbS9CeForV2ZORlAvcWV5THJ5WDREc2YyVHBUd3hic0lE?=
 =?utf-8?B?WWRuNVpXaEtRV2VZNkd3VmVheTgyTzVPaXprSVhpRk5yeHBacHF2bDBVWVZP?=
 =?utf-8?B?OUxnWnp2L0lSZ2VRTlppei9yMHJwcTB4T3NGZlFZa3VZdk1aempLM2FpcXpV?=
 =?utf-8?B?aFlheXNZZzZtSWJsY29ORTFqMmd0LzQxMWh4c1F6NlZVNnZKVStyM1NqMktI?=
 =?utf-8?B?YjJmSEpGREY1bUJ2NG9jeG5jNEI3U056UVB1UTR3blZQS0ovbE1hUis3TWhW?=
 =?utf-8?B?M3lzSFBEWnVRMjRpdmVDVDl0UFJSYUdUSnVoZmhSZHZiMktiaWxDVzVjQ1ZZ?=
 =?utf-8?B?eWdpS3FOSitWWFR0Sk5pVk1PUEx3ck5TdkFCTkMySytBRzhjYTdqb0NLMWlx?=
 =?utf-8?B?N3NwdXFLVFlYdTV6WkpWTE55Vk5PckRnZWJwYys0eG5HNUdPMmJaUkVxa2xv?=
 =?utf-8?B?M1UycHNWOVUvZ09XSVZOVm5zdUdUU2Y2Z2VMVFQrc0JUUFM4Vk1MS3RMWi96?=
 =?utf-8?B?c3kxUUROZkh1NjQwQUd1SURjUmFkQmJXRnlmUXlQZEFUZ1lucEJHQlhvejU5?=
 =?utf-8?B?Tk1DaHVYcFRxR3lpakRMd3ZRazFGcklRMGl2Ym9NeXRqeWxwdWVacjZZcG01?=
 =?utf-8?B?a3FqUTdKSnJoRE5SdEwyNTlHNUtpT3JnZVh4TjBxRG82VmNpcDF2WGN0c2pp?=
 =?utf-8?B?eVhTRDFiZGJlbmwzd3ZqWDMyOUlYTXlmU2NDK3MyRmJOdDJYamQ1UFh5Wkww?=
 =?utf-8?B?SmdPNlk1R3ZsODNkd090RnEya0htM09UMHpFWTlkckloYXVzeTNIZlZGQ0VE?=
 =?utf-8?B?bHR6QXdwSzQ1ZVBiOXY0WmplbnRHUVRHanlCMitCUkU2L1BHUmZBT3lCS2pF?=
 =?utf-8?B?YnR4SXNINVlnWnNYQ0hYYTgxMUQzRUs2RXJXcXJCNTdtenpVRjh3TjFzdWZM?=
 =?utf-8?B?bi9TcUw5c3R0ajFhN0l5MWtNZzc0bVE3QjlBRUFXN0hTVTAwMmVndmRKY08y?=
 =?utf-8?B?VmsvK1d1eVRLdDlNSTlVdEk3Y093VTZ2RlZiVklVcU1pSjk3U0lyeGhVa3Ju?=
 =?utf-8?B?RjBuUHAvV0ZFczlWODNNVVdGZ2lJektud0FTcm5oZWo4YVFLd1l3MXpxelpk?=
 =?utf-8?B?TXVCTlZHMGRtdExoQ1NTZWhWQXhnOHp3WHpkeTUwamlZS3hjcUlILzluMktE?=
 =?utf-8?B?czN6ZTY3emw0QlFROTZ0NThTMnJFMEFyUDNRVjg2dUhDdlBIZ3JIZGp1NkI1?=
 =?utf-8?B?ZjVjdUZwTXU5VVhDYkVEN1I3bHFWZ1lHYmtVN2dQMFo0dnBkWWVqcy9rQWV3?=
 =?utf-8?B?TzNtc1Mrbmk3NUVJay85RlNCNzZGdnR0R3V6SWVUbCtmY2c0SWkxMndRK0dy?=
 =?utf-8?B?UVNQU0FNWHFkTzNyeTREUEFEUFBlUjZWQjB4WU13Wm92WEc4WnNjVHlRSk9O?=
 =?utf-8?B?a3h2VE1nSVFXRk5IQ2ZTQUJjZUUyZmNxenBZSDc5NXJaSnJ2eFF5bzlzK2ZR?=
 =?utf-8?B?Vm1ya0h3T3BpV3JNSlN6ZkxWK3JsZHArL3pWNFpHbDViOVVBSGhCQ3ZkQk00?=
 =?utf-8?B?dkxIV1k1bUgvVW40NUJOaEJkRjVlTWVlSE0xazcxZEg5dVhwMCsxR1ZTMUZT?=
 =?utf-8?B?aDRzejY4RTRJdzRPWmlVb2E0TTZjQyttQk9ySFdZNDB3cHF5TVlwakhxRXpo?=
 =?utf-8?B?VGw5RDQ2QnAybklLS0l0R3lmNmtLanlrc1NPdjJ2aDRzL0V3MlMxenlmUHRn?=
 =?utf-8?B?djdPTHBHY2QzYm1ITi9zbmFQRlQ1bUUyL2ltbDV5bHczcktIZUQ5UVNPNkt1?=
 =?utf-8?Q?eywf6a4KdwU6Vgx7B6hSp/s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b7f65e-458c-48cf-6121-08dbe6317317
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 23:20:26.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwPhh8CxsDfIaEk3KsJbXl6bwGe3dLct8TFdzLC2Ew+hame+mbV7EevVitQeM5KBRLkNni77Ekrlk3dGMw34mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkbmVzZGF5LCBOb3ZlbWJlciAxNSwgMjAyMyA3OjA0IEFNLCBKb2huIEdhcnJ5IDxqb2hu
LmcuZ2FycnlAb3JhY2xlLmNvbT4gd3JvdGU6DQo+DQo+IE9uIDE0LzExLzIwMjMgMjI6MzgsIEth
cmFuIFRpbGFrIEt1bWFyIHdyb3RlOg0KPiA+IFNldCBtYXBfcXVldWVzIGluIHRoZSBmbmljX2hv
c3RfdGVtcGxhdGUgdG8gZm5pY19tcV9tYXBfcXVldWVzX2NwdXMuDQo+ID4gRGVmaW5lIGZuaWNf
bXFfbWFwX3F1ZXVlc19jcHVzIHRvIHNldCBjcHUgYXNzaWdubWVudCB0byBmbmljIHF1ZXVlcy4N
Cj4gPiBSZWZhY3RvciBjb2RlIGluIGZuaWNfcHJvYmUgdG8gZW5hYmxlIHZuaWMgcXVldWVzIGJl
Zm9yZSBzY3NpX2FkZF9ob3N0Lg0KPiA+IE1vZGlmeSBub3RpZnkgc2V0IHRvIHRoZSBjb3JyZWN0
IGluZGV4Lg0KPiA+DQo+ID4gQ2hhbmdlcyBiZXR3ZWVuIHYyIGFuZCB2MzoNCj4gPiAgICAgIElu
Y29ycG9yYXRlIHJldmlldyBjb21tZW50IGZyb20gSGFubmVzOg0KPiA+ICAgICAgICAgIFJlcGxh
Y2UgY3B5X3dxX2Jhc2Ugd2l0aCBjb3B5X3dxX2Jhc2UuDQo+ID4gICAgICBJbmNvcnBvcmF0ZSBy
ZXZpZXcgY29tbWVudCBmcm9tIEpvaG4gR2Fycnk6DQo+ID4gICAgIFJlcGxhY2UgY29kZSBpbiBm
bmljX21xX21hcF9xdWV1ZXNfY3B1cw0KPiA+ICAgICB3aXRoIGJsa19tcV9wY2lfbWFwX3F1ZXVl
cy4NCj4gPiAgICAgIFJlcGxhY2Ugc2hvc3RfcHJpbnRrIGxvZ3Mgd2l0aCBGTklDX01BSU5fREJH
Lg0KPg0KPiBKRllJLCBUaGlzIGNvbW1lbnQgZG9lcyBub3QgYmVsb25nIGhlcmUgLi4uDQo+DQo+
ID4NCj4gPiBSZXZpZXdlZC1ieTogU2VzaWRoYXIgQmFkZGVsYSA8c2ViYWRkZWxAY2lzY28uY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBBcnVscHJhYmh1IFBvbm51c2FteSA8YXJ1bHBvbm5AY2lzY28u
Y29tPg0KPiA+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBLYXJhbiBUaWxhayBLdW1hciA8a2FydGlsYWtAY2lzY28uY29tPg0K
PiA+IC0tLQ0KPg0KPiAuLi4gc2hvdWxkIGJlIHBsYWNlZCBoZXJlLg0KDQpUaGFua3MgSm9obi4g
SSdsbCBrZWVwIHRoaXMgaW4gbWluZCBmb3IgdGhlIG5leHQgdGltZS4NCg0KDQo+IFJlZ2FyZGxl
c3Mgb2YgYSBjb3VwbGUgb2YgY29tbWVudHMsIGJlbG93LCBmZWVsIGZyZWUgdG8gcGljayB1cDoN
Cj4NCj4gUmV2aWV3ZWQtYnk6IEpvaG4gR2FycnkgPGpvaG4uZy5nYXJyeUBvcmFjbGUuY29tPg0K
Pg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQo+ID4gK3ZvaWQgZm5pY19tcV9tYXBfcXVl
dWVzX2NwdXMoc3RydWN0IFNjc2lfSG9zdCAqaG9zdCkgew0KPiA+ICsgICAgIHN0cnVjdCBmY19s
cG9ydCAqbHAgPSBzaG9zdF9wcml2KGhvc3QpOw0KPiA+ICsgICAgIHN0cnVjdCBmbmljICpmbmlj
ID0gbHBvcnRfcHJpdihscCk7DQo+ID4gKyAgICAgc3RydWN0IHBjaV9kZXYgKmxfcGRldiA9IGZu
aWMtPnBkZXY7DQo+ID4gKyAgICAgaW50IGludHJfbW9kZSA9IGZuaWMtPmNvbmZpZy5pbnRyX21v
ZGU7DQo+ID4gKyAgICAgc3RydWN0IGJsa19tcV9xdWV1ZV9tYXAgKnFtYXAgPQ0KPiA+ICsmaG9z
dC0+dGFnX3NldC5tYXBbSENUWF9UWVBFX0RFRkFVTFRdOw0KPiA+ICsNCj4gPiArICAgICBpZiAo
aW50cl9tb2RlID09IFZOSUNfREVWX0lOVFJfTU9ERV9NU0kgfHwgaW50cl9tb2RlID09IFZOSUNf
REVWX0lOVFJfTU9ERV9JTlRYKSB7DQo+ID4gKyAgICAgICAgICAgICBGTklDX01BSU5fREJHKEtF
Uk5fRVJSLCBmbmljLT5scG9ydC0+aG9zdCwgZm5pYy0+Zm5pY19udW0sDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICJpbnRyX21vZGUgaXMgbm90IG1zaXhcbiIpOw0KPg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgQXJlIHRoZXNlIGNoZWNrcyBqdXN0IHBhcmFub2lhPyBJIG1lYW4gdGhhdCBp
dCBpcyBzdHJhbmdlIHRvIGhhdmUNCj4gICAgICAgICAgICAgICAgICAgICAgIGZuaWNfbXFfbWFw
X3F1ZXVlc19jcHVzKCkgY2FsbGVkIGJ1dCBub3QgYmUgcmVxdWlyZWQgdG8gZG8gYW55dGhpbmcu
DQo+DQoNClVuaWZpZWQgQ29tcHV0aW5nIFNlcnZlcnMgTWFuYWdlbWVudCAoVUNTTSkgaXMgYSBH
VUkgdG9vbCB0byBjb25maWd1cmUgQ2lzY28gU2VydmVycy4gDQpUaGVyZSBhcmUgaW50ZXJydXB0
IG9wdGlvbnMgdGhhdCBjYW4gYmUgbW9kaWZpZWQgdG8gSU5UWCBvciBNU0kgb3IgTVNJLXguDQpB
bGwgdGhlc2Ugb3B0aW9ucyBhcmUgc3RpbGwgc3VwcG9ydGVkLiANCg0KSG93ZXZlciwgd2UgZG8g
bm90IHN1cHBvcnQgbXVsdGlxdWV1ZSAoTVEpIG9uIE1TSSBvciBJTlRYLg0KVGhlc2UgY2hlY2tz
IGFyZSBwcmVzZW50IHRvIG9ubHkgcHJldmVudCBhbiBNUSAibWlzY29uZmlndXJhdGlvbiIuDQoN
Cj4gPiArICAgICBmb3IgKGh3cSA9IDA7IGh3cSA8IGZuaWMtPndxX2NvcHlfY291bnQ7IGh3cSsr
KQ0KPiA+ICsgICAgICAgICAgICAga2ZyZWUoZm5pYy0+c3dfY29weV93cVtod3FdLmlvX3JlcV90
YWJsZSk7DQo+DQo+ICB5b3UgbWlnaHQgYmUgYWJsZSB0byB1c2UgZGV2aWNlLW1hbmFnZWQgbWV0
aG9kcyBmb3IgYWxsb2NhdGluZyB0aGlzIG1lbW9yeSwgbGlrZSBkZXZtX2t6YWxsb2MoKSAoc28g
dGhhdCB0aGUgbWFudWFsIG1lbW9yeSBmcmVlJ2luZyBpcyBub3QgcmVxdWlyZWQpLg0KPg0KDQpU
aGFua3MgZm9yIHRoaXMgaW5mb3JtYXRpb24uIFdlIGNhbiBjb25zaWRlciB0aGlzIGluIGEgZnV0
dXJlIHBhdGNoc2V0Lg0KDQpSZWdhcmRzLA0KS2FyYW4NCg==
