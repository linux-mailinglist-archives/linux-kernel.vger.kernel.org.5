Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C67D76D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjJYVae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJYVac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:30:32 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 14:30:30 PDT
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DB0111;
        Wed, 25 Oct 2023 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3364; q=dns/txt; s=iport;
  t=1698269430; x=1699479030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X+6IsmwbfAW74kIrB8/iiCeHKvwjj/PHuIfdyv8mIKU=;
  b=Ei5+C428oCsrxcHibiySGOjmPdlz1wKy1Z4QX4mvB+fiVNEaFGqFjf5U
   GgEFc292Q3P9pTxqvXzoIhKBYPcU7XwiLKHIQ2/5oMMBuT7wHU8/iZSCF
   Xq6RYPdbJyFmqeGAkVcwAfpZrAHgxLqECV9CX747RsVjN6ASbBINT7fnU
   Q=;
X-CSE-ConnectionGUID: iPrxN6KaT3SFuikHVXqeRw==
X-CSE-MsgGUID: DZXiHD9pS/2mZL+kZ92Hxw==
X-IPAS-Result: =?us-ascii?q?A0AqAABkhzllmIgNJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZlJ4WzxIMYQhg0wDhE5fiGIDkTqMQxSBEQNWDwEBAQ0BAUQEA?=
 =?us-ascii?q?QGFBgIWNAEEAQiGQAImNAkOAQICAgEBAQEDAgMBAQEBAQEBAgEBBQEBAQIBB?=
 =?us-ascii?q?wQUAQEBAQEBAQEeGQUOECeFaA0IAQ4QgX2EKAEBAQEDEhEEDQwBATcBCwQCA?=
 =?us-ascii?q?QgRBAEBAQICJgICAjAVCAgCBAENBQgaglyCXwMBqSEBgUACiih6fzOBAYIJA?=
 =?us-ascii?q?QEGBAWybAmBGi4BiAkBgVCDaYRNJxuCDYFXgmg+gmECgTgOHBWDRDmCL4N1h?=
 =?us-ascii?q?TwHMoIigy8pjBkJeEdwGwMHA4EDECsHBC0bBwYJFi0lBlEELSQJExI+BIFng?=
 =?us-ascii?q?VEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1TXYQKgQUF4ERBGoFGhUeNxESFw0DC?=
 =?us-ascii?q?HYdAhEjPAMFAwQ0ChUNCyEFFEMDRAZKCwMCGgUDAwSBNgUNHgIQGgYNJwMDG?=
 =?us-ascii?q?U0CEBQDOwMDBgMLMQMwV0cMWQNsHzYJPAsEDB8CGx4NKzsDRB1AAwttPTUUG?=
 =?us-ascii?q?wUEOylZBZ1bg0kaaHZlFh8Llh5Ji0+NeJM7gS4KhAyhPxeEAYxymQeYPCCia?=
 =?us-ascii?q?wUZhH8CBAIEBQIOAQEGgWM6gVtwFYMiUhkPjiAZg1+PeXY7AgcLAQEDCYhvG?=
 =?us-ascii?q?guCNgEB?=
IronPort-PHdr: A9a23:xtM1ZR2E8HJ1FvaJsmDPZ1BlVkEcU/3cNwoR7N8gk71RN/3l9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUQwt5Gm1ZHBcA922fFjOuju35D8WFA/4MF92L/7pG4rbjOy81vu5/NvYZAAbzDa4aKl5e
 Q2/th6Z9tFDmJZrMK831hrPrzNEev8Dw2RuKBPbk0P359y7+9ho9CE4hg==
IronPort-Data: A9a23:1QxOhqpgthFlJpeDoLFepFXGsOheBmLRZRIvgKrLsJaIsI4StFCzt
 garIBmDOKyLazf1e9sgatu18kgG6sOBmIBlGgdq+CgzQSJHpOPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7wdOCn9T8ljf3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYATNNwJcaDpOsPvb8k435pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86rIGaRpz6xE78FU7tJo56jGqE4aue60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/yxWZcV7FLH7zXeXsPSJ32uYUHLQmM5AEUA1HbMo4+tNHjQbn
 RAYAGhlghGrjuayxvewTfNhw59lJ8jwN4RZsXZlpd3bJa95GtaYHeOTvpkBh2lYasNmRZ4yY
 +IaYCBzbRDJYDVEO0wcD9Q1m+LAanzXKmIJ8gzK/vVti4TV5CBD4LnNHIvNQZvQQPdx3UWq9
 zjm73usV3n2M/TGmWbarRpAnNTnmSL9RZJXF7Ci8PNuqEOcy3ZVCxAMU1a/5/6jhSaWX9NZN
 lxR4SE1rIAs+0GxCNrwRRu1pDiDpBF0ZjZLO+Q+7AfIwa3O7kPCQGMFVTVGLtchsafaWADGy
 HeIp8n5I2JMuYHOclyA97S0kwOrNBIKeDpqiTA/cSMJ5NzqoYcWhx3JT8p+HKPdsjETMWygq
 9xthHVh74j/nfLnxI3gpgiW2WLESozhC19ruFmKAgpJ+yskPOaYi5qUBU83BBqqBK+dSlSH1
 JTvs5fDtLhUZX1hedDkfQngNLit4/DAOzrGjBs0WZIg7D+qvXWkeOi8AQ2Sxm83aa7omhewP
 Sc/XD+9ArcIbBNGiocsPOqM5zwCl/SIKDgcfqm8giBySpZwbhSb2ypleFSd2Wvg+GB1z/BvY
 8rLL5r8UipGYUiC8NZQb7lFuVPM7n5mrV4/ubigp/ha+ePEPSXMGett3KWmN71ntctoXzk5A
 /4GZ5fVlH2zocX1YzLc9sYIPEsWIH0gba0aWOQJHtNv1jFOQTl7Y9eImOtJU9U8w8x9yLySl
 lnjARAw9bYKrSCdQel8Qio9OOqHsFcWhS9TABHAyn74gCJ9MNrxvfx3mlleVeBPydGPBMVcF
 pEtU86BGf9IDD/A/lwggVPV9uSOqDzDadqyAheY
IronPort-HdrOrdr: A9a23:R7hyDaHn/6ab0DRwpLqFrZLXdLJyesId70hD6qkvc203TiXIra
 CTdaogtCMc0AxhKU3I+ertBEGBKUmsjKKdkrNhTYtKOzOW9ldATbsSorcKpgeQeREWmdQtqJ
 uIH5IOb+EYSGIK8/oSgzPIUurIouP3jJxA7N22pxwCPGQaD52IrT0JdTpzeXcGPDWucKBJbq
 Z0kfA33AZIF05nCPiTNz0uZcSGjdvNk57tfB4BADAayCTmt1mVwY+/OSK1mjMFXR1y4ZpKyw
 X4egrCiZmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoTJ4JYczAgBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcV7WP4w1PwuwqgnSW5fkN+NyNyv/MfTvLr0TtngDi66t
 MT44utjesSMfoHplWk2zGHbWAwqqP+mwtQrQdatQ0sbWJZUs4QkWTal3klTavp20nBmdoaOf
 grA8fG6PlMd1SGK3jfo2l02dSpGm8+BxGcXyE5y4aoOhVt7ThEJnEjtYcit2ZF8Ih4R4hP5u
 zCPKgtnLZSTtUOZaY4AOsaW8O4BmHEXBqJaQupUBjaPbBCP2iIp4/84b0z6u3vcJsUzIEqkJ
 CEVF9Dr2Y9d0/nFMXL1pxW9RLGRnm7QF3Wu4xjzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeQP
 q3MII+OY6rEYIvI/c+4+TTYegkFZBFarxhhj8SYSP7nv72
X-Talos-CUID: 9a23:uVoEOWxY1ySSOswz2XquBgUVIto1VCP+xUuLGGGlCGVJdo2MRGWPrfY=
X-Talos-MUID: 9a23:oQZ7DQpoFx3BWtGvtf4ezx1QBMZIz/W2MwdXlKci+Mq2ZHZQKyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by alln-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:29:27 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 39PLTQTx024524
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 21:29:27 GMT
X-CSE-ConnectionGUID: Fep5u2VmSAO5xbsK2O5f8g==
X-CSE-MsgGUID: i5WDJUGITB2hqGVXh29b3A==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,250,1694736000"; 
   d="scan'208";a="5828319"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfMfjZ2mOJpZzj+IN6/RoGjQv5JJgbJ29r3UBlOJ2uIwwJc79J43G/jqgnkERAjwL/H/zFi6q3Ihj6GPfF8np1QJEyf107Vp5CRjmalvyWyF2lbKqueLTuf5s7c3GR1ETBb6yOecLD4ZGqDvKZL7X8G5FIq97CL12Oxg4odxb5rmoPJzPMunLCDkWm8IX8kg7ca4lachQud7yjAERDrOTExthykFaiYFveZ268InV9dv+a6AeSDjabBqNN1RRqMYQfPSbQNIoD6OO2Ss92q8qRjgn6y5/KqdZ17HywZCa/mTSnm/vuiPLeLrbvTnQ7NjxudmL0VEl6E03Arc27j+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+6IsmwbfAW74kIrB8/iiCeHKvwjj/PHuIfdyv8mIKU=;
 b=KhRGRKXPEZoV5lknL3yvpfOQ/3hJIIKWG0D9tmwQTH1kSw4VRY7AEw4DGd82DOP4ANZsKkTAW0hs7of0NPbIjyz+m436HB1g0B9x/ussh9SNwv27tzi3mjUwCwJCUMLvn/yhM8zAbaBYFICgr5X47LkxSmlTIqqBFymT65TUbStwWn/dpuF2zRQJ24x6KjB5TjjSTmW83iXMMgbd+xqsdn5NWX3cFzNc2EepkzwHi/FAoEVtwRmQwPHm/A+aWsHWzTj0ET4Gv+SK7p7S5ax2dux7uCidFiq0hdsqcfoVh4qWBA48m/guClKJSJpDLnBimRwBfuhvuil9BZWvCAY/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+6IsmwbfAW74kIrB8/iiCeHKvwjj/PHuIfdyv8mIKU=;
 b=DGf+WRGlofHxJ1MgAedK/5OgAtNUsWWff5VXFDzfRtrSnduuqbWzV3WtESJHSarifMscQ7PlX7qndvygwCgUa6/iuF2Sdjr4nxT+Djf+1UnFaF+fgZzg6Kv1sU1M4+9Gcnh7iExvVLA3KgOE89527UJ7hPtoeN7G8V/+2hp/6m0=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 21:29:24 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 21:29:24 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 12/13] scsi: fnic: Add support for multiqueue (MQ) in fnic
 driver
Thread-Topic: [PATCH 12/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic driver
Thread-Index: AQHaA4ip1F7nD6jDoEe8sXfc3wSCUbBa2JEAgAA0jwA=
Date:   Wed, 25 Oct 2023 21:29:24 +0000
Message-ID: <SJ0PR11MB58968AE791657557863D0FD5C3DEA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231020190629.338623-1-kartilak@cisco.com>
 <20231020190629.338623-13-kartilak@cisco.com>
 <573a7ab2-93ec-4184-9806-31a7ed99c04b@acm.org>
In-Reply-To: <573a7ab2-93ec-4184-9806-31a7ed99c04b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|MW3PR11MB4540:EE_
x-ms-office365-filtering-correlation-id: 8c6d94b8-c230-41f4-5aad-08dbd5a175a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2WVfokiMV+t2+8OMC6614NfB9phpsRVMm2iIsKeIUDenru3UPslT+fydQzr/EFU4ilWRmw9YszPpKdEiDEIADR843B9Obs3ddqsvbqMQ55hv8PMoBNd46439Lkj1rKXjG/emTo5aM8ztgHbsVdPeDAkEqVUukW30xgXhlqMh1cWUIUZweohqkLeGOUDBZwraT3Jql2xgyoZebhIZdL3qJnaKKfXJdPZ7KUf9VI8fZjaaL8Fd0Ixp8Whiekz8xMxqvfJX8pvDN+jDPddr543KEbCibIwZRRbWf23Pp4RO83RK0RIw166W5iNG5kYc2jWurqXcCwF4STSdk6L55RaktiOSd4gJWsT1o8FylYy6jQ864iiHaZ3I8LbrbhyuuiuGLFTmAMBhVUPTf/T2RPFoThYOVAVCUz+fCNdUHnPph5o6mwdxm1WK0J/pEY7KRn4O9OKMY534hOA7PpQQ0o88aFrjvg1O4YkyBPba9CeKGHUHjIanMK4vNl+ipys2G6xtonwjYnfpx5K5k3ZqA28GFEuG64ScJGzg58/MByKZYi4rq+6j6cYSz9DWtdPqEIWdUamf4cHb1J4/pIY8Q8JyEjPG2P9vcdyyQcv1E3/ZDTuqjwu0H275RmmW7gucaX27
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38070700009)(7696005)(6506007)(53546011)(9686003)(122000001)(38100700002)(33656002)(86362001)(41300700001)(4326008)(66946007)(2906002)(83380400001)(71200400001)(478600001)(55016003)(8936002)(8676002)(52536014)(64756008)(5660300002)(66556008)(54906003)(110136005)(76116006)(66446008)(66476007)(6636002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TS9uWlBTSkphbFhhY1ZaM0w4SW04NGplYnBTbkFxR3FhV2VaaHdHcDN0Tks3?=
 =?utf-8?B?UWFBWXZlUWR0MFlsdlIzSnNQbk1jQkRFUm5kTFdqWm9kZS9nQTJnL0RxT0xL?=
 =?utf-8?B?Yk5LbXRWMmdIR0cvSnIzeitzck9adXVPMXpoNjUrVmtLdk83V3FQYWVzSkFQ?=
 =?utf-8?B?MkdHemQwMkUvQU9vZzcrNzY1bWV1Y3VDWGU3VzhtQnM5NGNMUWhGaFdtNnFY?=
 =?utf-8?B?NElmQnhOMnBCcnRUY1NUYldSRkxhS0Y5ZXRYemw5MEk1QmFOT3k2RHcyVmRy?=
 =?utf-8?B?L3hVOVRVYS94MUF0N1dUVFByWWJXejZ2MXJiN3N2Mm1YRDdCVUpOTTRxOXNW?=
 =?utf-8?B?T01WanNHbEpCWVRBVVRPOG16Z0FjRzY3VGF0c1VXVnd0M2U1TmV6ZUM0Smlk?=
 =?utf-8?B?MEUwUmdYSmR2NCt5SFdqbFRuZDIyQ25lQVhRYXFpS3JxVFZHTnRVWnBzb1hz?=
 =?utf-8?B?SzVaeVRYVkZEMzNDMnVDejI3NEpiUTdnN0daeTB2KzZGV2dheGp1cVNLT2Mv?=
 =?utf-8?B?S2Q1MHVwVFpoQWo0UXRESll4UldYL0ZJc1Z3M3VxYm5CTzRQSUlaZlFiUXNN?=
 =?utf-8?B?amFJalNCY3ZnVXAyK29tMmo4Y3dQU0x3dWtVb21JQ0thYXhLdmJldDA5ei9V?=
 =?utf-8?B?OE1UTUN1c1h4Q1BHUm00aVBiWmRYaVExZEQwN1Nhd1lnOTFycGVCUmRXTDFI?=
 =?utf-8?B?aGtzMGt3MldLdE9SVVFHb2N6dVpBREtWSjdpa0dUQWhNdndwQmpQUUpuTXVw?=
 =?utf-8?B?NkRVV0w0RGRqeW9xaTNGcSt5OEE0a0k5bXdqdytLS1RkU1FpaUZRakh5cjdZ?=
 =?utf-8?B?NzliSGc1QXRnQjdORmhqamhmNzllUUxuck1vV3VJU01LUWpIZDcwYU0vNjdP?=
 =?utf-8?B?L213QjdBTkZsdC9BVmlGZGZBeHZCOXpoRjFhRTFSc3Rqd21QT0l4eFZTUXZD?=
 =?utf-8?B?aXNkOEZJamVpODVsZWJRcWNIVDZpQlFyczRFV0R4MDA5bktaYjNORE4wc3lQ?=
 =?utf-8?B?QU1sUTBnT1JnMkVwT01mYzNSc0s4aEowVENwa1IwdUdwWkh5Vlp2UkZGbzhP?=
 =?utf-8?B?U3dzZWlTUGhPeXRDRUdyWlQybW0yeUdmMFNnbk1Ja2pxTU5Wcmd3OTRWOFJ5?=
 =?utf-8?B?WjFjY2lrTEl2VWp4VHR5M1BzYlFmQU8rMDJ3bEJjWVBybVVJSGdDQ2xqR0lD?=
 =?utf-8?B?ek1zRDNHNU5mYzQrbXlXbUpKUXRFMzZpN3kzRjZWcnJXaEU4NG5rMHZXNjdO?=
 =?utf-8?B?ZTNWdVR1ZEM1S0t2VVEvb2QxOUZzek1GUWdZZUJ1WHJSeWs4NEFHbGkzK05E?=
 =?utf-8?B?K0xWUGdhZzN0eTQ3S0dnVEs4MkZuNFBHRTFhS3NhbGZ6TnllRnZiVEpXeEc2?=
 =?utf-8?B?U1Nab0Fyci9SSG5WQWlwckY5Yk8yTDRxeHFwSU1ja3ZLOHpxbHUzZ0VoYXNY?=
 =?utf-8?B?VFZJU29NcjY2WTRhTDR5SkxpWnUrVFF4ZjA0Z2J3b21WZFlSMzNBNXJDay9o?=
 =?utf-8?B?ZnBXSFh3UFk0SXZsQm45TTQzV25LWkdESWw0UTBBNEN5TkRoM2htaEZyeU14?=
 =?utf-8?B?QTYxNXhDS0NmczlnM2dXQjgrYjRIY3lXaWZSSTNDMzZxbzA5Z0k1VU15UUlK?=
 =?utf-8?B?OUo3azN2ejdKN0psV3dLSHE4R3I1WW9TM2VWODdoTTZCSW5hSWdGdHM3bW9n?=
 =?utf-8?B?Q2FyK2NZK1VOcmJ4NThBNmh2SkJvT1lKVGg5ei9FNHdLZFJtYVliVnNDRDg4?=
 =?utf-8?B?a2xPbnQvZW5kNnJHOGU1bmM3ZzhPSUVGUmU2Y05EZUE3WjFueXdtYWFTbDh6?=
 =?utf-8?B?THpTZFhSbmQvME9qV2lUTG5PajE3Z0U1cFJodmRGVTJWY0V1MHk4YUV6S21C?=
 =?utf-8?B?VTRJS3lyZ3BEQmRCYVg2T25lNU1KaVpNb0NwbFlFdVBoTmFrOFg0ZWZLYkNz?=
 =?utf-8?B?ZGppUHA0S3RITHhYUkNGTzJ6M0ZDTWE3YkJGbE9sMHVYK3ZhcG5vUzdtZFN1?=
 =?utf-8?B?SHhkUHBRUm5DN0srZDFFVHRCcCszNE9IZnlxMjY3WGVWWjFxWGlISFAwMjZt?=
 =?utf-8?B?eVplWEtrV0ZoTG8wZ3lwOUtMUlRaSklUQ3VxSTF5TTY1N3lMQmdZbjFzOFhI?=
 =?utf-8?B?c2k5bGNOc2d6TmYzcVNEZmUzQzZ0NXA5MzJRVjhKVXBKVVZZQU1lNS95eDMv?=
 =?utf-8?Q?JRHBiQWpFMbpz8XYJWpQQ0m2rNgBIQgYREilQDX/nph2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6d94b8-c230-41f4-5aad-08dbd5a175a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 21:29:24.2951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idx6FGIjbIICmlQX7yeS2SwlPCyZDYN/bDD8ucLiSvoNZbR1fFFe370YsssQdG3ylTR60LVb1KP8R1yzKk+oww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFydCwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBjb21tZW50cy4gSSdsbCBmaXggdGhl
IGlzc3Vlcy4NCg0KUmVnYXJkcywNCkthcmFuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4gDQpTZW50OiBXZWRu
ZXNkYXksIE9jdG9iZXIgMjUsIDIwMjMgMTE6MjAgQU0NClRvOiBLYXJhbiBUaWxhayBLdW1hciAo
a2FydGlsYWspIDxrYXJ0aWxha0BjaXNjby5jb20+OyBTZXNpZGhhciBCYWRkZWxhIChzZWJhZGRl
bCkgPHNlYmFkZGVsQGNpc2NvLmNvbT4NCkNjOiBBcnVscHJhYmh1IFBvbm51c2FteSAoYXJ1bHBv
bm4pIDxhcnVscG9ubkBjaXNjby5jb20+OyBEaGFucmFqIEpoYXdhciAoZGpoYXdhcikgPGRqaGF3
YXJAY2lzY28uY29tPjsgR2lhbiBDYXJsbyBCb2ZmYSAoZ2Nib2ZmYSkgPGdjYm9mZmFAY2lzY28u
Y29tPjsgTWFzYSBLYWkgKG1rYWkyKSA8bWthaTJAY2lzY28uY29tPjsgU2F0aXNoIEtoYXJhdCAo
c2F0aXNoa2gpIDxzYXRpc2hraEBjaXNjby5jb20+OyBqZWpiQGxpbnV4LmlibS5jb207IG1hcnRp
bi5wZXRlcnNlbkBvcmFjbGUuY29tOyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAxMi8xM10gc2NzaTog
Zm5pYzogQWRkIHN1cHBvcnQgZm9yIG11bHRpcXVldWUgKE1RKSBpbiBmbmljIGRyaXZlcg0KDQpP
biAxMC8yMC8yMyAxMjowNiwgS2FyYW4gVGlsYWsgS3VtYXIgd3JvdGU6DQo+IEBAIC00MDUsMjIg
KzM4OCwyMCBAQCBzdGF0aWMgaW5saW5lIGludCBmbmljX3F1ZXVlX3dxX2NvcHlfZGVzYyhzdHJ1
Y3QgZm5pYyAqZm5pYywNCj4gICAgKiBSb3V0aW5lIHRvIHNlbmQgYSBzY3NpIGNkYg0KPiAgICAq
IENhbGxlZCB3aXRoIGhvc3RfbG9jayBoZWxkIGFuZCBpbnRlcnJ1cHRzIGRpc2FibGVkLg0KPiAg
ICAqLw0KDQpUaGlzIHBhdGNoIHJlbW92ZXMgdGhlIERFRl9TQ1NJX1FDTUQoKSBpbnZvY2F0aW9u
IHNvIHRoZSBhYm92ZSBjb21tZW50IA0KaXMgbm93IHdyb25nLiBQbGVhc2UgZml4IGl0Lg0KDQo+
IC1zdGF0aWMgaW50IGZuaWNfcXVldWVjb21tYW5kX2xjayhzdHJ1Y3Qgc2NzaV9jbW5kICpzYykN
Cj4gK3N0YXRpYyBpbnQgZm5pY19xdWV1ZWNvbW1hbmRfbGNrKHN0cnVjdCBzY3NpX2NtbmQgKnNj
LCB1aW50MzJfdCBtcXRhZywgdWludDE2X3QgaHdxKQ0KDQpCZWNhdXNlIHRoaXMgcGF0Y2ggcmVt
b3ZlcyB0aGUgREVGX1NDU0lfUUNNRCgpIGludm9jYXRpb24sIHRoZSBuYW1lIG9mIA0KdGhlIGZu
aWNfcXVldWVjb21tYW5kX2xjaygpIGZ1bmN0aW9uIGlzIG5vdyBpbmNvcnJlY3QuIFBsZWFzZSBy
ZW1vdmUgdGhlIA0KX2xjaygpIHN1ZmZpeC4NCg0KPiAtREVGX1NDU0lfUUNNRChmbmljX3F1ZXVl
Y29tbWFuZCkNCj4gK2ludCBmbmljX3F1ZXVlY29tbWFuZChzdHJ1Y3QgU2NzaV9Ib3N0ICpzaG9z
dCwgc3RydWN0IHNjc2lfY21uZCAqc2MpDQo+ICt7DQo+ICsJc3RydWN0IHJlcXVlc3QgKmNvbnN0
IHJxID0gc2NzaV9jbWRfdG9fcnEoc2MpOw0KPiArCWludCByYzsNCj4gKwlzdHJ1Y3QgZmNfbHBv
cnQgKmxwID0gc2hvc3RfcHJpdihzYy0+ZGV2aWNlLT5ob3N0KTsNCj4gKwlzdHJ1Y3QgZm5pYyAq
Zm5pYyA9IGxwb3J0X3ByaXYobHApOw0KPiArCXVpbnQzMl90IG1xdGFnID0gMDsNCj4gKwlpbnQg
dGFnID0gMDsNCj4gKwl1aW50MTZfdCBod3EgPSAwOw0KPiArDQo+ICsJbXF0YWcgPSBibGtfbXFf
dW5pcXVlX3RhZyhycSk7DQo+ICsJaHdxID0gYmxrX21xX3VuaXF1ZV90YWdfdG9faHdxKG1xdGFn
KTsNCj4gKwl0YWcgPSBibGtfbXFfdW5pcXVlX3RhZ190b190YWcobXF0YWcpOw0KPiArDQo+ICsJ
aWYgKHRhZyA+PSBmbmljLT5mbmljX21heF90YWdfaWQpIHsNCj4gKwkJRk5JQ19TQ1NJX0RCRyhL
RVJOX0VSUiwgZm5pYy0+bHBvcnQtPmhvc3QsDQo+ICsJCQkJImZuaWM8JWQ+OiAlczogT3V0IG9m
IHJhbmdlIHRhZzogMHgleFxuIiwNCj4gKwkJCQlmbmljLT5mbmljX251bSwgX19mdW5jX18sIHRh
Zyk7DQo+ICsJCXNjLT5yZXN1bHQgPSBESURfRVJST1IgPDwgMTY7DQo+ICsJCXNjc2lfZG9uZShz
Yyk7DQo+ICsJCXJldHVybiAwOw0KPiArCX0NCj4gKw0KPiArCXJjID0gZm5pY19xdWV1ZWNvbW1h
bmRfbGNrKHNjLCBtcXRhZywgaHdxKTsNCj4gKwlyZXR1cm4gcmM7DQo+ICt9DQoNClRoZSBjb2Rl
IGd1YXJkZWQgYnkgImlmICh0YWcgPj0gZm5pYy0+Zm5pY19tYXhfdGFnX2lkKSIgc2hvdWxkIGJl
IA0KcmVtb3ZlZCBhbmQgaW5zdGVhZCB0aGUgZHJpdmVyIHNob3VsZCBlbnN1cmUgdGhhdCB0YWdz
IG5ldmVyIGV4Y2VlZCB0aGUgDQpmbmljLT5mbmljX21heF90YWdfaWQgbGltaXQuDQoNClBsZWFz
ZSBhbHNvIHJlbW92ZSB0aGUgbG9jYWwgdmFyaWFibGUgJ3JjJy4NCg0KVGhhbmtzLA0KDQpCYXJ0
Lg0KDQo=
