Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9097E2DFF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjKFUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjKFUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:13:50 -0500
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602DC1FD7;
        Mon,  6 Nov 2023 12:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=248; q=dns/txt; s=iport;
  t=1699301610; x=1700511210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jni4Xfb+YChyElYA02Kfq6box12eLsYvYuVqjurmua0=;
  b=Y3zIr9ec63T+JpfvVB3WRLJ+Ca9jbPI7lvzdOK8pGs7WHkIYeTUiK4gm
   7fuQ19rvlWu2KMOENEJMJ9Lzop2CKJAwgnu3T5UgXIWR78LMwVZOcmV39
   5iIiBqLBLQlHpcrVNy2nlHet7hBJvlJ30Kx1MpcChp31PRCT123noXGWV
   Q=;
X-CSE-ConnectionGUID: wxT7qKgrQ8WPev9qQd5RoA==
X-CSE-MsgGUID: OGBhJnp7Rq+TPd6IEuVBCQ==
X-IPAS-Result: =?us-ascii?q?A0AnAADxR0llmJhdJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOETl+IZZ1+gSUDVg8BAQENAQFEBAEBhQYCFocQAiY0C?=
 =?us-ascii?q?Q4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBRAOJ?=
 =?us-ascii?q?4VoDQiGRAEBAQEDEhERDAEBNwEPAgEIDgoCAiYCAgIwFRACBAENBQgaglyCX?=
 =?us-ascii?q?wMBoHIBgUACiih6gTKBAYIJAQEGBAWybAmBGi4BiAkBgVCINicbgg2BV4JoP?=
 =?us-ascii?q?oJhAoFig1k5gi+JLgcygiKDVI0NCXdHcBsDBwOBABArBwQwGwcGCRQtIwZRB?=
 =?us-ascii?q?C0kCRMSPgSBY4FRCoECPw8OEYI/IgIHNjYZSIJYCRUMNUp2ECoEFBeBEQRqB?=
 =?us-ascii?q?RgVHjcREhcNAwh2HQIRIzwDBQMEMwoSDQshBRRDA0IGSQsDAhoFAwMEgTYFD?=
 =?us-ascii?q?R4CEBoGDScDAxNNAhAUAzsDAwYDCzEDMFVEDFADbB82CTwPDB8CGx4NJygCN?=
 =?us-ascii?q?UMDEQUSAhgDIANEHUADC209NRQbBQQ7KVkFpRWSWoNESa4zCoQMoT8Xg24BE?=
 =?us-ascii?q?oxzmQyYPiCoCAIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OIBmDX495djsCBwsBA?=
 =?us-ascii?q?QMJi0oBAQ?=
IronPort-PHdr: A9a23:WWMvaBD4amf7oku/Gu2jUyQVoBdPi9zP1kY9454jjfdJaqu8us2kN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+iLzKlBbTf73fEaauXiu9XgXExT7OxByI7H2E5TOjsC+1Mi5+obYZENDgz/uKb93J
 Q+9+B3YrdJewZM3M7s40BLPvnpOdqxaxHg9I1WVkle06pK7/YVo9GJbvPdJyg==
IronPort-Data: A9a23:DbSAhqAncQCBihVW/xTjw5YqxClBgxIJ4kV8jS/XYbTApGh0gWcDm
 2IbDT2HM6qPamrwe4gibou3oB9S6JGEytNjOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4SGdIZsCCaE+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357hWGthh
 fuo+5eEYQb9hWYvWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxMUlaENQ4ZW7
 86apF2I1juxEyUFU7tJoZ6nGqE+eYM+CCDV4pZgtwdOtTAZzsA6+v5T2PPx8i67gR3R9zx64
 I0lWZBd1W7FM4WU8NnxXSW0HAlhLZEZ4ZzIO0HvjvSe0RzfSnex+fJHWRRe0Y0woo6bAElU/
 vAebTsKdB3G3qS9wamwTa9ngcFLwMvDZdxE/Co/i2CCS697G/gvQI2SjTNc9DQ5nNxPGf/dT
 8EYcjFoKh/HZnWjP39OUs5gx7bw1imXnztwj32/pYgx+zfp1U9N6LSzEffIRPahfJAA9qqfj
 juWozumav0AD/SbyDyY4jevi/XJkCfTRo0fDvu7++RsjVnVwXYcYDUSVF2msbyigVW/c8xQJ
 lZS+Sc0q6U2skuxQbHAswaQunWIuFsXXMBdVrR84wCWwa2S6AGcboQZctJfQMM2iJAvZjMw7
 w+2p973VCVWvOCvTlvIo994sgiOESQSKGYDYwoNQg0E/8TvrekPYvTnE4gL/Emd042dJN3g/
 9yZhHNh2OhL3Kbnw43+rA+X2Wv9znTcZldtvl2/Y46z0u9uiGeYi2GA81PX67NLK5yUCwDHt
 3kfkM/Y5+cLZX1sqMBvaLtWdF1Kz6/YWNE5vbKJN8V4n9hK0yXzFb28GBkkeC9U3j8sIFcFm
 nP7twJL/4N0N3C3d6JxaI/ZI510nPm6RIm5CqiEM4Imjn1NmOmvonkGiam4gTiFraTQuf1X1
 WqzKJz1Vi9KVcyLMhLsH75DuVPU+szO7TqDGc+kp/hW+bGff3WSAawUK0eDa/tR0U93iFu9z
 jqrDOPTk083eLSnOkH/qNdDRXhUdiJTLc6t9KRqmhurf1AO9JcJUaGBmNvMuuVNwsxoqws/1
 irmBRcBmAug2ievxMfjQikLVY4DlK1X9BoTFSctJl2vnXMkZO6SAG03LvPboZFPGDRf8MNJ
IronPort-HdrOrdr: A9a23:XAhiYqyTtp4HQTPTzGZgKrPxaegkLtp133Aq2lEZdPULSL36qy
 n+ppQmPEHP6Qr5AEtQ6OxoWJPtfZvdnaQFmLX5To3SLDUO31HYYr2KjLGSjAEIfheOlNK1up
 0QDpSWZOeAamSSyPyKnjVQcOxQgeVvkprY+ds2pk0FJWoFGsQQizuRSDzrbXGeLzM2fabRYa
 DsnPav0ADQAkj/AP7LYEUtbqzonfGOvpTgZhINGh4g7yezrR7A0tTHOind9C0zFxdUz5kf0U
 WtqWHED6OY3M2T+1v57Sv+/p5WkNzuxp9oH8qXkPUYLT3ql0KBeJlhc6fqhkF3nMifrHIR1P
 XcqRYpOMp+r1nLeHuunBfr0w78lB4z9n7Zz0OCi3eLm726eNt6MbsFuWtqSGqf16MShqA77E
 uN5RPBi3NjN2KFoM063amRa/glrDvunZNoq59hs5UWa/ptVFYWl/1ewKuQe61wQR4TL+scYb
 NTJdCZ6/BMfVyAaXfF+mFp3dy3R3w2WgyLW04Yp6WuonJrdV1CvgMlLfYk7zw93YN4T4MB6/
 XPM6xumr0LRsgKbbhlDONERcesEGTCTR/FLWrXeD3cZe06EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdsWIpYUrhBcCHwZUO+BHQR2e2Wyjr16hlltVEk6y5QKCuPTyISVgoncflq/IDAtfDU/
 L2I55SC++LFxqmJW+I5XyJZ3B/EwhobCROgKdPZ7unmLO+FrHX
X-Talos-CUID: =?us-ascii?q?9a23=3Adq/7i2odf1v26H/EpDELjD7mUd81TiLE73jKGh+?=
 =?us-ascii?q?HMWt3GaSsRQKq/4oxxg=3D=3D?=
X-Talos-MUID: 9a23:yZwboAr7w0RGlMBUQu8ezxZNHsdK5bzxMllOra0K5eipKBJaEA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:13:29 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6KDSj8024774
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 20:13:28 GMT
X-CSE-ConnectionGUID: c50X3CkjTbCc/PoqhKhZYQ==
X-CSE-MsgGUID: assTNky4R0OoH9rObTh92Q==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7148166"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu4x9/lKqIog3cweR9AaRLkO9sb3P1CLFv34nQWVdkvHCMWAcsl3Px83NJjjrGEwQDEsrSyMawCvRpLykrOcjCZZGFNMBb+8ffrINH5kOUiTED4q5argjlKbVx6XFFh65Y60AonifmerqokMkNCpyVPEZfbIbNMEfV52HwyAAmwd/MP5Nykl06OosCVI8fiFobM3Xeo6THxm9n8kHdpQbMYE4m9Evbmapr36LbDWbvrDjrODMA5XNOn46T8vukYcEaUtz3G1g5ZNWMgDBYPVl8j/X4BPEkm4JbM4ajM/HiOnawpvMDTZWw6IpBUeEe+1V8Uz7Jbt8vfatdGke/x1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jni4Xfb+YChyElYA02Kfq6box12eLsYvYuVqjurmua0=;
 b=HMnVjK6k66beWoTIX7P8E0qzgN2OnDWCBBtXljGFVFP25gMFgdLh4q+7Z7o9I8fs9pWMFfHcr4rvYWSRvVGrLJpWEL+yuoSiR5SV7GKSLw0wW/BR9g5eVdvXc1LqGZ5cxep/7fMNvsFV9YMoIkXqa4RRdUqRM4FaahX+WlJsLcLnXo2UugX/oGk7U4qKa9/5HQSaJM1Fj6cw+Pn+9P9WBrXmYFTcHOd8dLg7Y4UjOOYy2L09BLKAzItMPuy/VCyfMiX/DkFVgNktxhhqfArKOkOIis2pMuZNMsQKET8eBwKdzPlWO46WAQ5XU4zEdq7JtfiuDJNJ+flVyXlFh/fgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jni4Xfb+YChyElYA02Kfq6box12eLsYvYuVqjurmua0=;
 b=nCZEgBEIJawRoDBAiYIz3gUszg6I9WC1/cOvU1VeWihlvzVSsUASa8faGO02BnnqtImehCdbs5I7nqUztT3xruDcBtZcKJHNW0G8Q8gBIfVauRCcXEACoLfMeG3cF8MEW8C/DB87X51Dz1+GMezGPI4SLJcfMry28HF4/2vXlQo=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 20:13:25 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 20:13:25 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2 07/13] scsi: fnic: Modify ISRs to support
 multiqueue(MQ)
Thread-Topic: [PATCH v2 07/13] scsi: fnic: Modify ISRs to support
 multiqueue(MQ)
Thread-Index: AQHaCP/y59Ks8y7Xu0ubxV7UiJN2NLBmrzkAgAcZwRA=
Date:   Mon, 6 Nov 2023 20:13:24 +0000
Message-ID: <SJ0PR11MB5896D2EB102093B37FC894C9C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-8-kartilak@cisco.com>
 <9538044a-e761-45ca-8507-5a3377cbe993@suse.de>
In-Reply-To: <9538044a-e761-45ca-8507-5a3377cbe993@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|IA1PR11MB7175:EE_
x-ms-office365-filtering-correlation-id: e892655a-1082-4205-4472-08dbdf04d500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sGkpXPfQn2SxXnlWRKVeGQzTgg6WGb1vjHNUPkEUiMZHwLjOAjfaG3vRnvnYsa7oQpI9H47YUy+lMH0HmRes31/DRKqMOAxLS/qC94RvEmscoPUs9nD4IDIcMvFBeQaYtr6JVZKF0vWI8qgXazG/07rbMsnE1SbXuWJr88DRENvRcMT1NK8RoIJE4HxzGw45xU8sw7rhN1qrYekIR95FzuIO1Z6a7C0qydN/GHH9OmvLZZBPrhGg0knskU1fyCkVZlfD0GEe6SGtaLf6eVwg4x3Bp7RhxDArzFYD/tsXSGtoF0/UPRiLxOrwZGUpLiHFHLfWnVvkw6vr2sEL3fBFyrAhItdI5B+yx0f0r+5c0xysuzfMCPUyLfdZC5NsDr4RyKpvSK1JKtahx0XdWF7w+vyVwirXItQA9gB6HvhcrWVQu2Ff8oNX5rRWR6AoqVCtTgxlvfHGBneGuTMircpWdWBuO+Nod8PE4EB3ZAJyszLjDDYHTpECkRyPHPtD0TilYh+dVtH7zUeMkF59+ImUy4XdnyKqqWJ3ZZwc+NcXh0lUt7elghXzzY+poll20Z8+3NeSDZJ1gYIn5EQ7AEjqDdfDVZ0+AH4f5dEfNl9tEje7ZAYEfXTxDliry4OgCrp9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(558084003)(2906002)(38100700002)(4326008)(8936002)(8676002)(41300700001)(33656002)(5660300002)(86362001)(9686003)(52536014)(122000001)(6636002)(316002)(64756008)(66946007)(66476007)(66446008)(66556008)(76116006)(54906003)(6506007)(7696005)(53546011)(71200400001)(38070700009)(110136005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlNQZTdkTFlYSCs3V2JRQlFobTFnZ3JvVUk3NFc2b2J2cTZlUUc0Rm5xN1pO?=
 =?utf-8?B?QkVhK1JjRlAxTGhvUTVLeHo5UVUwaXJtcnFvQzVNeFNNblRFMkd1bTdhNXZZ?=
 =?utf-8?B?eDdnbFpJUHJhQ2dUekhmdERTVk0xSEFUYjI2dURENFVENy84eitsL2cySmMv?=
 =?utf-8?B?b0ZPUXdRNllDdkJpcXRUK3FORWdsOGlRZXRmT25FVTJ6ZURWNGU4N2hoSWlL?=
 =?utf-8?B?TllSVndZUmloU3N6RGpLQnZLVjRZN1Rwam0waU5LOFlTd0ZjT0tuaER2aU54?=
 =?utf-8?B?LytLdUlWWHgxN3lyMnErbEtDNGUrckg5TmRYVlR5ZE4rSXYwaDBLZEZZcll5?=
 =?utf-8?B?Y0U1blg5SkVKNGptZkxPSUpaczh3WVh3V3BveDgrQUZNNU5tM3lFL1g4NHdE?=
 =?utf-8?B?K2R1Y1JINXFUczMxakRHcjhkemlxam5KWitYTnRTd0taMWFtV3VjS01uT3d2?=
 =?utf-8?B?OTJNd2RLb0ZnM2lHeHRDZzNUbFc2YmE3UnI2MG5RRWIrM1FFc3JZUjRwLzZK?=
 =?utf-8?B?anpkNS94MDIwYUFtd0hLeEp0cVdvcXV6OEo5cVBieXg0eEpuWWJscStXTkxk?=
 =?utf-8?B?aytBRVhiQVJXMU12MklkUG5GclBuT0ZmNVQ5N1FPM1dnclcvWEs0aVhXOXNz?=
 =?utf-8?B?amplV2cweGh1eENCMWJiOVZFRHAyU2UxVDNuSFFMWlBLY3htUHp5K2hqbTkw?=
 =?utf-8?B?ZTlJQmtYMUZmdE5teTNJdnlodHhQNWR1N3JSN1NZZnI2NnNEYmk3M0FZT0Rx?=
 =?utf-8?B?cHNxS1p0YWxHbk53WlAxTmwwZ1B0V3pxY0lNVlNTUnU0WlpqcXJkb0prdHMr?=
 =?utf-8?B?akoweWpKakh2UWJUaG1sejlGMXIwV1hkWXMvZHR1UVRCNTdxZE4ybTNxWkVK?=
 =?utf-8?B?TlJJV3BZaENlbUsvS2tQMHI1UXZvNHNxekJCZ0tUeEtZNXdDN3pCMk02bFVu?=
 =?utf-8?B?bDA2SVk4cHRyR2JWYkY0NWZpTytGRElSRkhIYjRqY0FDTmNJYmlQckNpQk5N?=
 =?utf-8?B?UlI5NTF6UjNlMVFrZ2hhQ0pUQVB0VkU4VTlueGY5WC91WVphLzE1VXNkbUo5?=
 =?utf-8?B?VUVad3RmNEdoUUlUYXF0UzZvRzkvT3RtYjA0aWRWVjdFWGVldXhEU3kyTmIy?=
 =?utf-8?B?c1V4R3lJc01pTnRiY2dZcGZiSVdBSCs0bENQTmlkbk9mUmpEZkM3bE13eHRN?=
 =?utf-8?B?VWwyVFErUDhwZ3N3QVdmS3dmNld1Qk1UK2xUYThUeVQ5Vm9MRDVsMnpiK3Bs?=
 =?utf-8?B?WVl5OHoreUhPRDRCY0VVemxlZCs5amE5VitWQXdDMGpjTGNQSjB1OGRIR2lx?=
 =?utf-8?B?a0NMYTdsOEw0Yi9jczBUVDgxRC9DYkN2YThIZS80ZnF2WENDUUJuKzFyTTk5?=
 =?utf-8?B?OW5CVmM4TGxhNkZIT0xIZnBJcElxWFRzQnYxUkt5MzV3L296L24vbWM4M0hJ?=
 =?utf-8?B?RFFKSy9rbjZPSllDdm9rWmxWVy9LWTVGQy9OMDZLdjRXTFlndEM2RVFCaVly?=
 =?utf-8?B?SWowd3AzREJrUklZRGV6T2hISExPcXhqV1FyMnNnc3E2VjFpYjV3aVZZWklM?=
 =?utf-8?B?MDlkMlZhZXZJanBvUjh2M3Z3Z1VUSW5NMVExR29NV1Jjd0d3UVlUTFVuUW1L?=
 =?utf-8?B?VjhkeW42b1BNV2JhUGw3MSs2UkR4dGdmN1Q5ZEYzSnplSElkdnh1TmxrT3ov?=
 =?utf-8?B?elp6S0pRY1BsSndkNmtqa2pKc3N0MnVSVk1zVksxSkEwM3JPVTZuOU93blR4?=
 =?utf-8?B?QnV0amZGQzlHdFliTmJxbFhnUzZpZExTWXM0bXkyaEpsb1JlbmJwL2FtbnNM?=
 =?utf-8?B?d1ErSjhvM090dzUzQnJZYXFyeUx2S3hITU1DRWNrUnB3WitRWUpkcThvSFFq?=
 =?utf-8?B?aEZQSDJXcGJCakt5SmQ3Mk1nWEp6alVFOUY1R2dpaHIwS2VDRk5DK2pzZDJl?=
 =?utf-8?B?TG95Qm9OdGt0d3B3OHZZQmVycDhPTFE2Kyt6SVVuU1kyRFhRTEdidDh2RCtY?=
 =?utf-8?B?ODhxckdYRTVZQjRsalp0QVdWK2t1VStYZVI1UHB6TTJLZTAxSUY0UjNZVzV5?=
 =?utf-8?B?dSsybU9RSmp2NWpUeHlZdUJZb2xtZllWc1ZyZVZlektSRTFJbzR1cVplMlJZ?=
 =?utf-8?B?cGJFdlNQSVhtc1BieWdEMmxIM1ArclVsM3o3Q3JSa1ZMWHJISS80SnBLaHFB?=
 =?utf-8?Q?PkDejSRzK+TuMrBrvg/AaM0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e892655a-1082-4205-4472-08dbdf04d500
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 20:13:24.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcGE4u7XbT2sCM2P4Qlk196TymoAtfeaF28vThQglJOvtxuAm8AsS/CwTFvs9+X6N6GRdAc5/iGRlGESyR6vqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7175
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMTI6NDYgQU0sIEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4NCj4gUGxlYXNlIGF2b2lkIEM5OSBzdHlsZSBjb21tZW50
cy4NCg0KU3VyZSwgSSdsbCBtYWtlIHN1aXRhYmxlIGNoYW5nZXMgaW4gdjMuDQoNClJlZ2FyZHMs
DQpLYXJhbg0K
