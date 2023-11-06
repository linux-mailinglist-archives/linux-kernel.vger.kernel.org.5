Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904907E2D64
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjKFT5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:57:51 -0500
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6228DB;
        Mon,  6 Nov 2023 11:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1360; q=dns/txt; s=iport;
  t=1699300668; x=1700510268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q/oIiCHxDKm2yii3FkV1vvbBtR+lVjp72nI2MHBPbSE=;
  b=H+xzOeHIEhIr81h6mHTOH/c4r0dtR6VX7zujdybaMcShxztt8bx41bny
   EA35jmIA+n/YHJf9uilGZI0qRHXAzhOH7KLOKtgADKLJPfGrBM6Xzhvuj
   rjjA7l/M3sqsB1b08XQFsmvH4voSDTrB95zvCG68VmEfQv9fzeVV6D6Pq
   0=;
X-CSE-ConnectionGUID: kpi6v9IuQHK9sa57sUbHZw==
X-CSE-MsgGUID: xJv49NrrQWmnDWRv1PE+ww==
X-IPAS-Result: =?us-ascii?q?A0B2AgDEQ0llmJxdJa1aHgEBCxIMQCWBHwuBZ1J4WzxIh?=
 =?us-ascii?q?FKDTAOFLYhlnX6BJQNWDwEBAQ0BAUQEAQGCEoJ0AhaHEAImNAkOAQICAgEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeGQUQDieFOwglDQiGR?=
 =?us-ascii?q?AEBAQEDEhERDAEBNwEPAgEIDgoCAiYCAgIwFRACBAENBQgaglyCXwMBoGIBg?=
 =?us-ascii?q?UACiih6gTKBAYIJAQEGBAWybAmBGi6ICgGBUIg2JxuCDYFXgmg+gmECgWIVg?=
 =?us-ascii?q?0Q5gi+JLgcygiKDKymNDAl3R3AbAwcDgQAQKwcEMBsHBgkULSMGUQQtJAkTE?=
 =?us-ascii?q?j4EgWOBUQqBAj8PDhGCPyICBzY2GUiCWAkVDDVKdhAqBBQXgREEagUYFR43E?=
 =?us-ascii?q?RIXDQMIdh0CESM8AwUDBDMKEg0LIQUUQwNCBkkLAwIaBQMDBIE2BQ0eAhAaB?=
 =?us-ascii?q?g0nAwMTTQIQFAM7AwMGAwsxAzBVRAxQA2wfNgk8DwwfAhseDScoAjVDAxEFE?=
 =?us-ascii?q?gIYAx4DRB1AAwttPTUUGwUEOylZBaEdMV6CPgGWR0muMwqEDKE/F6oALodGk?=
 =?us-ascii?q?EogqAgCBAIEBQIOAQEGgWM6gVtwFYMiUhkPhU6IUhmDX495djsCBwsBAQMJi?=
 =?us-ascii?q?0oBAQ?=
IronPort-PHdr: A9a23:bBegAxPt2uCSxtHN2t0l6nfLWUAX0o4cdiYc7p4hzrVWfbvmptLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgrDmgKUYAIM/lfBXJp2GqqzsbGxHxLw1wc+f8AJLTi820/+uz4JbUJQ5PgWn1bbZ7N
 h7jtQzKrYFWmd57N68rwx3Vo31FM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:9MPwj6Ph7PhptATvrR2Yl8FynXyQoLVcMsEvi/4bfWQNrUp3hTFUn
 2MXDTzXO/qNMGKkfIh/aYy39hsPvsWHxoBnHHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdaphyFjmF/kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/W1jlV
 e/a+ZWFYwb8g2AsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTLiXmdoXv0T2m0RK6bUQNbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0V3XC8pJtA0qDkwIwgvxdk/y5WPrVHpqGWAGWGke/C1ESbLGDRydVcExRjVWEY0r4f7WBm7
 /cULnUGaQqOwr/wy7OgQe4qjcMmRCXpFNpA4Tc7kneIVrB/HM6rr6bivbe02B8zj9pSHPLXZ
 OISaCFka1LLZBgn1lI/UclnzL/21yGjG9FegEK3u/ZmxXLJ9TN01pTSCsSMQvHJWtoAyy50o
 UqfrzimXXn2Lue3zTuD72LpheLVmy7/cJwdGaf+9fNwhlCXgGsJB3U+UVq9vOn8kUWlWvpBJ
 EEOvCkjt64/8AqsVNaVYvGjiGSPshhZUN1KHqhnrgqM0aHTpQ2eAwDoUwKtdvQlrM5oW20Ly
 2apvILyDGEwq4CfaUCCo+L8QSyJBQAZKmoLZCkhRAQD4sX+rIxbsv4pZos9eEJSpoClcQwc0
 wxmvwBl2OpO1Z9jO7GTuAGY02j19/AlWyZsvl2PNl9J+D+Vc2JMWmBFwULQ4fAFJ4GDQxzc+
 nMFgMOZqusJCPlhdRBhos1TRdlFBN7cbVUwZGKD+bF9rlxBHFb4LehtDMlWfhsBDyr9UWaBj
 LXvkQ1Q/oRPG3ChcLV6ZYm8Y+xzk/mxT4W4CqyMPocWCnSUSONh1H82DaJ39z61+HXAbYljU
 XtmWZ/2VC1DWfgPIMSeHb9Ej9fHORzSNUuKFcykkHxLIJKVZWWeTv8eIUCSY+UihJ5oUy2Lm
 +uzw/Cikk0FOMWnO3G/2ddKfTgicyNhbbio8JM/SwJ2Clc8cI3XI6WPkepJlk0Mt/k9q9okC
 VnmARAAkQqu2iKdQehIA1g6AI7SsV9EhStTFQQnPE2j3D4oZoPH0UvVX8JfkWUPnAC78cNJc
 g==
IronPort-HdrOrdr: A9a23:VWEn/ahK5PR897R0rilATNzsn3BQX5923DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sdi9qBPnmaKc4eEqTM6ftXrdyRuVxeZZnMXfKlzbamLDH4tmpM
 VdmsdFeaDN5DRB/KHHCUyDYqgdKbq8geGVbIXlvgtQpGhRAskKgXYde2Km+w9NNXZ77PECZe
 KhD7981kCdkAMsH7+G7xc+Lo7+juyOvqjLJTQBABkq4hSPizSH1J7WeiLz4j4uFxl07fMH62
 bqryzVj5/Pjxi88HDh/l6Wy64TtMrqy9NFCsDJoNMSMC/QhgGhY5kkc6GevRguydvfq2oCoZ
 3pmVMNLs5z43TeciWeuh32wTTt1z4o9jvL1UKYu33+usb0LQhKSfapxLgpNycx2XBQ++2U45
 g7mV5xcKAnVC8oqR6No+QgkSsaznZc70BSytL7xEYvIrf2IIUh37D3unklUKvp2EnBmd0a+C
 4ENrCH2N9GNVyddHzXpW9p3ZilWWkyBA6PRgwYttWSyCU+pgEy86I0/r1Wop47zuN3d7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUPhvAQOAl7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P0bjE9eH0pFH+g3EBG+9QTPuwMdD4IURgMyweJP7dSmYDFw+mcqppPsSRsXdRv
 aoIZpTR+TuKGP/cLw5ljEWm6MiX0X2fPdlzerTAWj+1/4jAreawtDmTA==
X-Talos-CUID: =?us-ascii?q?9a23=3A8kafemnPK280+wzBNgJAIR3IP+zXOX7FzSnOcm6?=
 =?us-ascii?q?lMEZKGaacFACLxalEodU7zg=3D=3D?=
X-Talos-MUID: 9a23:ZpKwZQpjL/V7DZEc1hMezyFAKps5xb60MX8Il7k5gdfdDQEzJCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:57:48 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6JvlBl023341
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 19:57:48 GMT
X-CSE-ConnectionGUID: MIDSlvQYRH+CKr2yF9DZQA==
X-CSE-MsgGUID: 5myvX6fFTIm6Ea4ioWu03Q==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7146533"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:57:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1fDugNx4sW9QQd42Rc2/hO3qhZC6ZyGNB/iOXcDhNK6uc+ruLaLiEIIt6n0KhJb8HfXU3ScL7A9jj6jQrh1Wh73YeteedZxOx0fHrb4KEBLmfHmJevKtJA1nDy2/CfS4qRxLNop8wbuU/ZiP0p9EuNbJZtyw28dxnIDuZEjNuRRKYjPNdmrLQw+59sryoAXN0gDrSSsKyuxW5fEZH28RvX3h8s/kYHKi/yCweXqA7ln8yqkYzpeTxT83QmrOM1wtSN7MzEyheLuKQXHKuQ7iu6BkJ4qwQ+Cc5ZqhupzamKuCsKphelFCmy3SSwMqdGUrY74mwTluBdpNgMxhos3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/oIiCHxDKm2yii3FkV1vvbBtR+lVjp72nI2MHBPbSE=;
 b=lPCwT0VFSUT1gvWu0vvvCfeLsGdsjOId3vWmpiYAG/UkPXCNlvuwz+kQNYWlDN2eDwUXk3rZNjXRLyWd+LDU2tD/+6k+tm4e/teR2x4YvuXz2Cu5fxzfHmBL4l7bAPEk3CUt/OXXYuzeu1cUSyS+ZrLYTXmtMEvixr4MEG4wyzGx+tnPp0vUh0WfVZLrfQTelY36HPDv18OjjdGVJhFZ0pvBl6XhFRrC/M8Mm3Ki7gfFo6Ki4powM6tfp06dgL70pwVSzKpspRUtJOyhukQxEC9zZBO34QjD/Ec2PfgMPBIAmRx7xuwE89gfDblxAL5v037BrVmyFN9tG2cHb0DoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/oIiCHxDKm2yii3FkV1vvbBtR+lVjp72nI2MHBPbSE=;
 b=GrTv/vsWV6+L8dmqNawxSwnxDUltMd0AfianhDFEgj7e1ZUb5vfQFHokleMI9qerRubjKwvyqhMoGrtQAbUeUt9je+PDNcJsVFidUEcjyMS2vvtVoPgpC2Mbn9v4uyCdwokSuFwSGsPv2BIvNQl6G5vjin4iiiIAr7AFYTjjPdA=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 19:57:46 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 19:57:46 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Hannes Reinecke <hare@suse.de>,
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
Subject: RE: [PATCH v2 04/13] scsi: fnic: Rename wq_copy to hw_copy_wq
Thread-Topic: [PATCH v2 04/13] scsi: fnic: Rename wq_copy to hw_copy_wq
Thread-Index: AQHaCP/wf7xaATeiY06kRcxwOdMtq7Bmqm0AgAcaCkA=
Date:   Mon, 6 Nov 2023 19:57:46 +0000
Message-ID: <SJ0PR11MB5896D93A94AD77BCDF0C2477C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-5-kartilak@cisco.com>
 <67350990-ada0-4979-9289-e44aae844f3c@suse.de>
In-Reply-To: <67350990-ada0-4979-9289-e44aae844f3c@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|CO1PR11MB4788:EE_
x-ms-office365-filtering-correlation-id: 088eec6e-c860-4115-e892-08dbdf02a569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VyaLWZ/kRYWCwIhUQsjpDq05SLKkb/ucP4r+KkfvWdye+REVhscWs+Pc9xLyM7yY/+4izj4kOmsGg+LbqjVsSXgRPyJl9RdUnv1RPEHsLwIZgIQnbZLRBWtF3iIRQI6eqBkhPUxQj0hOyHeKgoYJk0AkndAvtFDr6l0FK12FaWQU/jX3pjIVH9cj0P6CZDpmM9wnWydSFU4We1+EvjfH6d2JSgAg6iK5Zrv5pDv907TGuddx6hSSRy+2rh3Q2haJZbtN6nZ2WWmgI1vuW2n0g5oo5X7jeCUqdlnSQbEFBAjNoTaOion3wBTgx2g26KFdG3cVJscfwe1/0zL/7QEPs3jjJLZmZkZC6oGGQPXovxR34jrU7rnGxCw9Wo9d3xWlm/dRviloIky+dRmcnDJ/O2IFIZnL7AlUfmHpwi5kmBnYOEhulP5y6SwpuUiePcCDF0jyS1jthu7J4IrYK6q/gU7nbjZ92SmgV+9LIJg1nw8GwMO0M62Z5dGgjQIJt8o/SdgMZ2WbWu9xPGp+UgNZsFFaWfLXlk3hpfmp93sjAEElmSxeibaPqdIiYCoMp9aoeLafBvykR0QKju3k1tYC+I02gY6wehc1NKibdyUF0LY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(38100700002)(53546011)(6636002)(122000001)(110136005)(71200400001)(478600001)(6506007)(7696005)(66446008)(76116006)(54906003)(66556008)(64756008)(66476007)(9686003)(66946007)(5660300002)(2906002)(8676002)(4744005)(52536014)(33656002)(4326008)(86362001)(41300700001)(8936002)(38070700009)(316002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2U0M01rS3RoWXRTWTIrMlZTSVdzUlZqVDVFelNYUHl4RDE1d1dWNk50cnRy?=
 =?utf-8?B?WFZKYXBYQkhFVElLRkliME1Obzl1aGYzbGxRMERxcVJjWVZ6VUtlczVPNWhy?=
 =?utf-8?B?dXpGa3cyMW9BZXJRM3pTWFpFemF4TW5abSszQ25WWXpBdzNzNUpON1BaVTEx?=
 =?utf-8?B?ZVZmc1ZUdFVsUi9YU0F6ZFc2cy9sRnhLWnJHZlZmcVF6V01BSFJONGxPdDRx?=
 =?utf-8?B?NVNaeW5OSytsaWhUSEpBTzlHWlhHbWdlWGJCUHdOY00xWGRETEdFWVUvWTRh?=
 =?utf-8?B?N1ZZd3JLVm4xc29CeGZlQ2pES3hXeWdldHhid21iVkkya2V3ZlBwK3pyRTRR?=
 =?utf-8?B?ekJsVE00M1VWVXBTdFI0RUZmQm9pSHZJM0tHeVdXZVhwZjU0eWltcXpXODBz?=
 =?utf-8?B?OTBYQ2pkWVNTWDlFTGtXajgzc2tTS1phWjFBZTQ4ZzNPOWxUMEtRN1d3ekM2?=
 =?utf-8?B?MGV0WU9xZUVuZW81b2FZNUplTzZyZFhqWjFzeStqNy9ZMUQyeWdLUDdtMDg3?=
 =?utf-8?B?VHV0bnpKemlMRThZdTNWVW1TeDV3Ym1EZmVwbWt1UmF0RVJkOE5kbG9sOEU5?=
 =?utf-8?B?bytoeEV6TjB1WkIyT2JUeXVCSjRReDZ2WkdRaFFBTHNVWGltQWVyYWVjRlBG?=
 =?utf-8?B?eElEOWdGdk9KQ051WUFXbXJRenlrQUVEN080RHk2c3pIUWRQUXcwWEoxd2NO?=
 =?utf-8?B?eEVNQmluWms2bXVCNVEvRTcrNm1aY2FmWER5cDRVNjhJRnl1eFRBaGNnamxu?=
 =?utf-8?B?blJuamRXU21mbTBnMkcrTEJRT1dpTmFMazVKU255NXN4SzdzdkE2OEdtNldn?=
 =?utf-8?B?aVlzRExva1pWb1dnTWFGYmFMVWxJYnZjcitiTG9rcTRCcjlxTXdweWYxMmwv?=
 =?utf-8?B?U2owdTRla2QxbGJMczI1V0JlVkdxcHBUc21IcHpKTkpzWm95SDkzSXVwd0J2?=
 =?utf-8?B?aGkxaU0vb0s5Yjk5bWwrN1E5T1lBRG5OazgvSmNkdEpPcEdvbkE4dnd5QnUr?=
 =?utf-8?B?NDhJTVpSODIzVTBYZ2NGQmNzVzZ2bW1rQ0tkR24zY1hqSmVlK3pLMitsa0Vl?=
 =?utf-8?B?S21Wd1dFSVV2NXZ3UkhFR2I2czRpVUpkTEFISHZWUThlcFRYZTN5TjNKRFFC?=
 =?utf-8?B?YThzQ2ZQK0wvd3J5dWExODdkQlJNTExxNHkvQUdNTmNmVGJBVThtblE1c1Qv?=
 =?utf-8?B?NEJvdnIwWU9RVFk3YnYyVXBLT2Z6K2FxNmZCTUsxclB0L0kxWHprL2RqRjZn?=
 =?utf-8?B?YUZTTXFoVDBKYzkzL0NINFdpaDFrNG1DYkU4R2plMStXakc0b05JMDZsMGdC?=
 =?utf-8?B?YmROWWdhSy9pNEtMUnp3TWVreVc0QVN6MUtOcVllTHpmTWZQck5uWEduSGw0?=
 =?utf-8?B?bEZkZ1k2OUE2L2ZQb3MvQnNVSEhScUpSUlVnQzZGc1BoZ29HSW03VGFxRWtp?=
 =?utf-8?B?T0JDRHVySlk4d1R6OTdVUnlGa0c0RGJKQkowa0ZwRU9RcXJkWU5tWkxVTDBt?=
 =?utf-8?B?dTd1WnJZZ0hrQWJqdkdLQmxBZTBRd0c5KzN1dUxuVzAzc0Nqam1HV3p5L3NC?=
 =?utf-8?B?SDVBSmhOaGZiYlVuOG01KzRFdTJuNnFaamdqeE05ZjBYTVVtaHRIdGdKMTV1?=
 =?utf-8?B?aDhlaHJvcld2RVJaa2U0eFcxUTRCeGpVa3FQMVE1Ty9oT1JLUVBuYzhranF2?=
 =?utf-8?B?NXQ3NTRFbUJsQkhvVXZxTmFzT0l0UURZWWRTSVRNTmdySVBVZ05IenNjN2k1?=
 =?utf-8?B?YnowTW9uTVN6K0haVW5oYldJQjdFWVIyTWxFY3FpZ0F6UzRja3BXV0NDZEU2?=
 =?utf-8?B?bUl2TjBSOHMrOHZoeGFVWjZGQWZzN0EvRFZ3VExMbVZHWjhhdy83NXZvNXR1?=
 =?utf-8?B?dytnWWNNdkxCK1RxLzlJamEzK09zWjJFQi9LS2gxN2szdlI5UFNXR01RYk4w?=
 =?utf-8?B?clI5emNFVDNxNHp5Z3BtSXlJMTVUQlNWSVV6aFNYUGlLNGtJSGQ4RGpQU3la?=
 =?utf-8?B?Z1NGSE44K3lSVTFndktXbzZwOTU5YVB2QWV3ek5scGhLSWxtdCtQMXNIR0tV?=
 =?utf-8?B?OWVPMjBkblp6YS9VL3h0SUo0WEdqSXFsYVJyVzRKK2JTVkdsOWRaUEtReC81?=
 =?utf-8?B?MCtiRFBoZ1dWblh2UGZDZ2s0dDU1Nk90NGpMTUk0UnU5cWNZazFtUHhMNXJn?=
 =?utf-8?Q?8FLMDmfpLWxUVlISr90eN+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088eec6e-c860-4115-e892-08dbdf02a569
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 19:57:46.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDUT7j3rKJ6up+5G+6UaeQmViqbLixdvUL5stRFQLRq8FmjJx/2j/e0LTGnZzDOsbntHvplT/bYQSEq9lEjLBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTI6MjkgQU0sIEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4NCj4gT24gMTAvMjcvMjMgMjA6MDIsIEthcmFuIFRpbGFr
IEt1bWFyIHdyb3RlOg0KPiA+IFJlbmFtZSB3cV9jb3B5IHRvIGh3X2NvcHlfd3EgdG8gYWNjdXJh
dGVseSBkZXNjcmliZSB0aGUgY29weQ0KPiA+IHdvcmtxdWV1ZS4gVGhpcyB3aWxsIGFsc28gaGVs
cCBkaXN0aW5ndWlzaCB0aGlzIGRhdGEgc3RydWN0dXJlIGZyb20NCj4gPiBzb2Z0d2FyZSBkYXRh
IHN0cnVjdHVyZXMgdGhhdCBjYW4gYmUgaW50cm9kdWNlZC4NCj4gPg0KPiA+IFJldmlld2VkLWJ5
OiBTZXNpZGhhciBCYWRkZWxhIDxzZWJhZGRlbEBjaXNjby5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IEFydWxwcmFiaHUgUG9ubnVzYW15IDxhcnVscG9ubkBjaXNjby5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogS2FyYW4gVGlsYWsgS3VtYXIgPGthcnRpbGFrQGNpc2NvLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGRyaXZlcnMvc2NzaS9mbmljL2ZuaWMuaCAgICAgIHwgIDIgKy0NCj4gPiAgIGRyaXZlcnMv
c2NzaS9mbmljL2ZuaWNfaXNyLmMgIHwgIDIgKy0NCj4gPiAgIGRyaXZlcnMvc2NzaS9mbmljL2Zu
aWNfbWFpbi5jIHwgIDggKysrKy0tLS0NCj4gPiAgIGRyaXZlcnMvc2NzaS9mbmljL2ZuaWNfcmVz
LmMgIHwgIDYgKysrLS0tDQo+ID4gICBkcml2ZXJzL3Njc2kvZm5pYy9mbmljX3Njc2kuYyB8IDEy
ICsrKysrKy0tLS0tLQ0KPiA+ICAgNSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAx
NSBkZWxldGlvbnMoLSkNCj4gPg0KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJl
QHN1c2UuZGU+DQo+DQo+IENoZWVycywNCj4NCj4gSGFubmVzDQoNClRoYW5rcyBmb3IgdGhlIHJl
dmlldyBjb21tZW50cywgSGFubmVzLiANCkknbGwgbWFrZSBzdWl0YWJsZSBjaGFuZ2VzIGluIHYz
Lg0KDQpSZWdhcmRzLA0KS2FyYW4NCg==
