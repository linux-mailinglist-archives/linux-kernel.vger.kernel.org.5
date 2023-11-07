Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3D7E4877
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjKGSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjKGSlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:41:44 -0500
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6498610F5;
        Tue,  7 Nov 2023 10:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1002; q=dns/txt; s=iport;
  t=1699382502; x=1700592102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BgeaM4zBD1ryYKt1d/jmi7Sd0vc4zGs4uJRkrxlTC1Q=;
  b=K1iqRTdu/sZkjsLTj5+AqohGaNrAa65HmKc3XhhIGOFmvT8xLeiv6cVX
   pOvJrM3452xBL3uuQJMJyqdE3OhioDfAqSH2PxJ8q12Pt+yRAY1y6aAgm
   a0HyXbzDWiyfbJ92iYI2ruSWCXKVJ4fWrXP2+Nx33WcHS1fEaK/taAdXb
   g=;
X-CSE-ConnectionGUID: +m6lyHK9R3+7i2zz6BfBBA==
X-CSE-MsgGUID: cPbMiLXoQ6Ob2vxO8ESYrw==
X-IPAS-Result: =?us-ascii?q?A0AmAAC+g0plmJFdJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOETl+GQIIlnX6BJQNWDwEBAQ0BAUQEAQGFBgIWhxACJ?=
 =?us-ascii?q?jQJDgECAgIBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBHhkFE?=
 =?us-ascii?q?A4nhWgNCIZEAQEBAQMSEREMAQE3AQ8CAQgOCgICJgICAjAVEAIEAQ0FCBqCX?=
 =?us-ascii?q?IJfAwGgGwGBQAKKKHqBMoEBggkBAQYEBbJsCYEaLgGICQGBUIg3JxuCDYFXg?=
 =?us-ascii?q?jcxPoJhAoFig1k5gi+DcoU5BzKCIoNTjSYJd0dwGwMHA4EAECsHBDAbBwYJF?=
 =?us-ascii?q?C0jBlEEKCQJExI+BIFlgVEKgQI/Dw4Rgj8iAgc2NhlIglUJFQw0SnYQKgQUF?=
 =?us-ascii?q?4ESBGoFGBUeNxESFw0DCHYdAhEjPAMFAwQzChINCyEFFEMDQgZJCwMCGgUDA?=
 =?us-ascii?q?wSBNgUNHgIQGgYNJwMDE00CEBQDOwMDBgMLMQMwVUQMUANsHzYJPAsEDB8CG?=
 =?us-ascii?q?x4NJygCNUMDEQUSAhYDKyIDRB1AAwttPTUUGwUEOylZBaEugkCBOJYeSa4zC?=
 =?us-ascii?q?oQMoT8XhAGMc5kMmD4ggi+lWQIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OIBkfg?=
 =?us-ascii?q?0CPeXY7AgcLAQEDCYtKAQE?=
IronPort-PHdr: A9a23:aZFSEhbo7WnzPx4i6UPKYRD/LTDhhN3EVzX9orI9gL5IN6O78IunZ
 grU5O5mixnCWoCIo/5Hiu+Dq6n7QiRA+peOtnkebYZBHwEIk8QYngEsQYaFBET3IeSsbnkSF
 8VZX1gj9Ha+YgBOAMirX1TJuTWp6CIKXBD2NA57POPwT43bldi20+mx05bSeA5PwjG6ZOA6I
 BC/tw6ErsANmsMiMvMo1xLTq31UeuJbjW9pPgeVmBDxp4+8qZVi6C9X/fkm8qZ9
IronPort-Data: A9a23:bNvYcqxBNRsx+bXr/096t+cKxirEfRIJ4+MujC+fZmUNrF6WrkUEy
 TRJWWuCPvnfNjbzctt1Oo7ipB5S65GEz9U3G1Bu/lhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCea/lH0auSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 YiaT/H3Ygf/gGctaj1MscpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE88jmSH
 rurIBmRpws1zj91Yj+Xuu+Tnn4iHtY+CTOzZk9+AMBOtPTtShsaic7XPNJEAateZq7gc9pZk
 L2hvrToIesl0zGldOk1C3Fl/y9C0aJuu7qZJWmfkp2plA6ZciH+0atEAmscFNhNkgp3KTkmG
 f0wMjsBaFWIgPi7heP9Qeh3jcNlJ87uVG8dkig/lneCUrB3GtaaH/iiCdxwhF/cguhNFOzCZ
 s4QahJkbQ/LZFtEPVJ/5JcWxbzz3iKiL2UJwL6TjaEP6U3S6Dx26ebKOoDLavvaaP5khFnN8
 woq+EygUk1Fa7Rz0wGt9nOqm/+Kni7hXo8WPKO3++Qsg1CJwGEXThoMWjOTpfi/l177QNlEK
 mQK9Sc066s/7kqmSp/6RRLQnZKflgQXV9wVGOog5UTcjKHV+A2eQGMDS1atdeDKqud1QGIux
 3+qzumyRmNu6q+HF1iT3J29+Gba1TcuEUcOYioNTA0g6tbloZ0ugh+ncjqFOPPr5jESMWygq
 w1mvBTSlJ1I0pFWj/TTEUTvxmPz9sKQH2bZ8y2OBjr9hj6VcrJJcGBB1LQ2xexLIIDcRV6bs
 T1V3cOf9+sJS5qKkURhodnh/pn3u55p0xWF3DaD+qXNERzxohZPmqgLsFlDyL9BaJpsRNMQS
 Ba7VfltzJFSJmC2SqR8fpi8Dc8npYC5S4W0DKGJMoYWMsUpHONiwM2ITRDIt4wKuBZ0+ZzTx
 b/HGSpRJS9AUP8+nGbeqxk1i+dymEjSOl8/tbiin0j4jtJylVaeSKwONxOVf/sl4aafyDg5A
 P4BX/ZmPy53CbWkCgGOqNZ7BQlTfRATW8usw+QJLbHrH+aTMDx7YxMn6el/K9UNcmU8vrqgw
 0xRrWcClQel2ieddVvVAp2hAZu2NatCQbsAFXVEFX6j2mMoZsCk66J3Snf9VeNPGDBLpRKsc
 8Q4Rg==
IronPort-HdrOrdr: A9a23:BzSGxKDz1y+UNxzlHejpsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskdhZJhBo7y90KnpewKkyXcH2/hgAV7EZniphILIFvAs0WKG+UyDJ8SQzJ8h6U
 4NSdkYNDS0NykFsS+Y2nj4Lz9D+qj6zEnAv463pBkdKHAPV0gj1XYHNu/xKDwPeOAyP+tCKH
 Pq3Ls9m9PPQwVwUu2LQlM+c6zoodrNmJj6YRgAKSIGxWC15w+A2frRKTTd+g0RfQ9u7N4ZnF
 QtlTaX2oyT99WAjjPM3W7a6Jpb3PH7zMFYOcCKgs8Jbh3xlweBfu1aKv6/lQFwhNvqxEchkd
 HKrRtlFd908Wntcma8pgao8xX80Qwp92TpxTaj8DneSI3CNXcH4vh69MVkmyjimgwdVRZHof
 t2Nleixt5q5NX77XzADpbzJkpXfwGP0AkfeKYo/g5iuM0lGf9sRUh1xjIJLH/GdxiKsrwPAa
 1gCtrR6+1Rdk7fZ3fFvnN3yNjpRXgrGAyaK3Jy8PB9/gIm1EyR9XFoj/A3jzMF7tYwWpNE7+
 PLPuBhk6xPVNYfaeZ4CP0aScW6B2TRSVaUWVjibWjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DEXElDvWA/dkryAYmF3YFN8BrKXGKhNA6dh/129tx8oPnxVbDrOSqMRBQnlNahuewWBonBV/
 O6KPttcrbexKvVaPB0NiHFKu5vwCMlIbgoU/4AKiaznv4=
X-Talos-CUID: 9a23:35Kio2ATh1GgSkP6E2piqkoFOuN0SCaek3aKMV3mI2hDYpTAHA==
X-Talos-MUID: 9a23:mXSuQAW2Cldv26zq/DTUjhRjEPdv2vqJAhoTgbJWlvK1LzMlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 18:41:41 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A7IffVg003404
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 18:41:41 GMT
X-CSE-ConnectionGUID: MBRuegIcTNqH3Mim+qb/cQ==
X-CSE-MsgGUID: lDbsUMU1T7ChD695i25cQw==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,284,1694736000"; 
   d="scan'208";a="7352214"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 18:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFRqL17MVj0YZR/VM8Gpo8JLfslC7IxS508pJ8OUQYO4JDHwPMsZ/NqhTWcdc5r6n3P2I/hN8ancEi0LWJB7HpW7GDZSWE85OAMmObZA3NJJSwqP4MuOiahlIUttJjElSg+GwYjgBlmJ5jXZyKOpl2VgWCXZ1C5LbXuVGaxnigNcGIdzD+KK/DeCAgVii+m+m4zI/Lh4bVaIYTzFCKFFtDKfUZ1du2vIuu2JwYLberDKtpGc8OjFSVBR3yKiHU8Ii6f8lz5JcicoZDXK+YdZ1Qzx8HL0VMO/2RPULcIXRjfihrz6Wd9JgpIymxY9urPrDh6Pko9pvZHsSd7oXPC9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgeaM4zBD1ryYKt1d/jmi7Sd0vc4zGs4uJRkrxlTC1Q=;
 b=UHV+yMSYso3tcHyiKUFR3ONIulOcqCsnYgch+jBYNkoTzxr2FPDGEki7buHGbSvDPbGubMEcRR/M5iRLH/hZHIaHAcu4isn0HCeiuEbG7TbSKjEZZJsUDhZMCE6zxgqoI9dSfJOOUxBHLtkwDDUA3IuTH1BfoK7jdnmktHpFhVHSfum2cv5ZfQmZAe5kx6QLHpmiTPkfEuW/SGRRgKR/wpon3TYCdyqL3ABUmXxWuwn7AB3tj56AF2wP62N//6JwbUCHM/S2XK/Az/hb2MMFQPeGCz1ZNrchLJVdWQY+Kz3D5+PNwCqWoLUQHMdgm3eT5QQKQO/Q887c/loZItte6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgeaM4zBD1ryYKt1d/jmi7Sd0vc4zGs4uJRkrxlTC1Q=;
 b=DqWbtPe/3vBMzaCrnU3/qAYifZqGiqP68KMfQ56JjX2qdqXOKgixbIESTlcNfPicO1SNIc3xGUpzR03YNUKYnJF2RiQAvknEZEIyhOa0RRlemheWalHsoSjwa/fbSSzbbjisn5CB9avCIKZAajPeVn6FMKEcM0hG6H+bp/wd8DQ=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Tue, 7 Nov
 2023 18:41:39 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 18:41:39 +0000
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
Subject: RE: [PATCH v2 13/13] scsi: fnic: Improve logs and add support for
 multiqueue (MQ)
Thread-Topic: [PATCH v2 13/13] scsi: fnic: Improve logs and add support for
 multiqueue (MQ)
Thread-Index: AQHaCP/2MFkSdLeZq0m6/Pp6+iIsGLBmsvEAgAcb0ZCAALbcAIAAu92w
Date:   Tue, 7 Nov 2023 18:41:39 +0000
Message-ID: <SJ0PR11MB5896DC0CC401E400A0557AF6C3A9A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-14-kartilak@cisco.com>
 <2e7c1749-428b-4c88-8e0e-df6ed4d8def5@suse.de>
 <SJ0PR11MB5896E9241A26DACE35684E12C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <a2853642-b79a-4860-abd6-3e218171e491@suse.de>
In-Reply-To: <a2853642-b79a-4860-abd6-3e218171e491@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|SN7PR11MB7666:EE_
x-ms-office365-filtering-correlation-id: e9721fab-c427-47e8-7628-08dbdfc12ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1LCMDya7ESxAdqz0+Tyux5+feb0J4NNLenWoEWNQ1Y/9XbjF/YWQ3mqV+9uzOKST/enGT5ufj3L9vnYuXiPCmBJtxXfhUzOmAedxcen60qCcQ9wjSdZBVD+Ohdi2Snou7t0P2dglE7gm5TPIoSmw84enSRR2dM5bVqUTsCuj6VY/yLC0QfRTf0cnmlUDiv5rg0IYZBd55zatg6ud7VBwAbhHoW3naYYlbL96ECby2J+teE8oqLYqd8l+CretCk0p+CtMxhGOJ+V6K07Qd52wbcAJcoY1m1c9KTd07dJZTpLwSvt5vt/S1cXpehwW+uSAyQFLp2nZfdzjD9XfwFWHHom/oZwWPXKTg/n8vVGPvqJcKkDVaRMrimYzXbmePCIonCTIEQUbKs2vxr7ehJbfxVq4dyXr/z8AjlYlI8xefA5F9REo0fbd88G8k7BPiG8tdqhgP9tqGN4bbJv3KiM4ghb/M8dC1+r6avaw4ZprnCvrzqNIf6FBZ3KGcyENrMpq5GUueNvPNbqppnUJ1U+w0tgMt+qVXfszE+wpIhE2d5BtR9VbDd+SKR9eSTSIr6s4whjSGBfS2EtaJDpyEt9nzVAZ2gxJ3jQtISIrzN2G407IYbqyqboyb2avh5i716D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(122000001)(9686003)(8676002)(316002)(38070700009)(76116006)(4326008)(2906002)(110136005)(8936002)(66446008)(52536014)(64756008)(33656002)(54906003)(86362001)(41300700001)(4744005)(6636002)(66946007)(66476007)(66556008)(5660300002)(71200400001)(53546011)(6506007)(478600001)(55016003)(38100700002)(7696005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk1UU0dMTEE2b3BkUUJpRTFYcFMyTVU4TVM2Q3M4eFkyc0xadHJjLzBhVE5i?=
 =?utf-8?B?alFJL0d2Z1ZLODBLd1lkbURDVGJmRXErdDQ3cEpTNlZPeFdDYWFaMzJuVCta?=
 =?utf-8?B?WUVUMHlYWmo0TUJLSlJzckE0S3l1Tlh3V3M0K1UyamVXcXRCdXNqbC9iWW4x?=
 =?utf-8?B?QkhnZkd3TVdzUGtLbjhoc0c1TWdkWUlxTUNtUFp0Q1lJenNORThtcUFzZTZJ?=
 =?utf-8?B?UE9aZDlhbEZqSTJSM2sxYm9yNWE5NGp1Y1ZFWVNXT0FOZ1JDRm56MFlJSVJD?=
 =?utf-8?B?YWRsbmVyZUpDMWowc2h2anlIUUtKQW9XMjBwMURYUVNVdkMxVG5wc0F6WXBH?=
 =?utf-8?B?Q2ZhdTZobmJ2clF4UmhPMTFXc3BwTVpabk96OE55NkM2Q25mZGtHV1YvZ0p5?=
 =?utf-8?B?Zk5SMCtCN1JUNHBjUERIajJWd21JMy9lV2daNVhPTTlPeGhDRDRBTGF0VmY1?=
 =?utf-8?B?eXlVMkNTWXlaaHZOSHliL3p5S2lMbUZrV1laWGc3OEdYUC9VRVJjQnVPQ0t6?=
 =?utf-8?B?bzU1ZVo5cjJRbG43TzFEV2JLNzc2eVJabGVNVDRuR0swa3Jrd3JJTlBGUWFY?=
 =?utf-8?B?WCtTamRsTSt3M0tpb2tiVTJ2MDdoUXhoMFF2V2QvZDA5VXdhWEZlWEtKNVVR?=
 =?utf-8?B?ajlvbFJGeCtlNlpPbzRCbUtzTmtTYlZuM1JsQmxaaXVSbjY1dDJtN2tkVEll?=
 =?utf-8?B?czRxc1d1SDNuSXFQZ3BoNWVkbWNDNHFwNStNM1NwS1NBSDh4YU5KS2FMZlVL?=
 =?utf-8?B?a3VFWmJ6N28rZndma0JsdXZjTzViMEROM1JIbXVURUU0M3V1VXJ1c25FcFpr?=
 =?utf-8?B?WExoampGMERWWDMxSEJiLzZnNEVIaEJTQjlDandlUjlkWUI2VFNram5DeUhL?=
 =?utf-8?B?czduZTlUQ0pjYXlMdTJ1dUlCRlRFZDhTMzNLSEV3cFRQQ1Z3dmd0VFRpWENI?=
 =?utf-8?B?Z0cxdzFKSVpqU1AzL2l4QU1mVEovcXMrR2NLaVlnSXJQN204Q0FMajBtRi94?=
 =?utf-8?B?Y2pLL0ZoeTZtNmI0MmV6TWJ2RVpFdjJLdHU5Q3JHd3FhRUZ6ajdaanAxVVEx?=
 =?utf-8?B?cGIwOEJNVW5ydkY0Ry9OdVZwakQyZTdlMUhjOG1GYWdRSE9FNWkyRXRIN29P?=
 =?utf-8?B?WmN5SWNFWWNwNnVqTmE5cE13UENDVUxaRFpSeUI5dnE4VkNLbkVFYjg3dFB4?=
 =?utf-8?B?Y1BQWHUrd3pubUFVK1RUVVh4SENLRklLeWs1L1VsSUVYU0twZnIydHRHdnM1?=
 =?utf-8?B?OE1hK2VQSldKOG8vaVREUVRDVkNWUmVYK1F2WWs3SjJmYTAyQnE1dDhWUmY3?=
 =?utf-8?B?K3JRU2VmMmtjcUJmeElxZElYdysxZThLUFhDcnNMRnBCaTNtZVRQTGx6NUVO?=
 =?utf-8?B?d3VYa1IzWmdEVGlvN1JwS1lPRHdrWkU4WG5DUHcxVE9IWnNFOHZvclc5eFlq?=
 =?utf-8?B?NFhCclM3Mi9mcmZFMnBqMzA1ZkgzTlZ5YlhMWGNHNDFEeDZYRVNVK25RcXdZ?=
 =?utf-8?B?MElxekgyTm05dWxpZG5Xb05vSnJIVjVEaE9HcExyei90eEpBQWZqTFlvRVNz?=
 =?utf-8?B?Tmlnc3ozemwvNHc2dHdOc3VaWW5uaTRKV1dBai9EZlR2SER1M3N4OWxodWZ0?=
 =?utf-8?B?elkzd291T3NDem5DZkRIMGFQMzJlcGhMSk02WndHQTR3ZjVZT1hqN0V5ZDl2?=
 =?utf-8?B?TjhROURqQ2IxZnlYRHptdGlHdUYza1o2UW5pVmhqa3p6NFRYMmwwWCtYOE5E?=
 =?utf-8?B?Ulorejg1bHB0YktROVl1aGZ2V1ZpdDU5bG9sc1NQUmZoMmxINEZIdG9KWEdn?=
 =?utf-8?B?cnYwTDUweW4zVjIvWDZTTjZlWnFSN2NhTzFTeVF5T2F5Z1ppaW1ZQU94cWty?=
 =?utf-8?B?TFZIc2ZDc1BNYVJBRTBST3RxWEgreWRhMlZVemFUNGhydjJzdnpOV09yM09I?=
 =?utf-8?B?RFJhcGJFbHBLRWlyN3ZUYW9LWTRvcXRZOWlhYWM1YWxJUS9Rb25lUWpCSmQy?=
 =?utf-8?B?cjNuaEcxR29pcnlmdEdtRVRIZFh3QklGN2VCdjhwcjAzZUtBcElvckxINU4z?=
 =?utf-8?B?eUh0ZENwWWxvSWJoYTBzSWthMkVBc2tIVzBaeC8yTXNRTnVyOGZZNWhQZWRy?=
 =?utf-8?B?cS80MlpaRnl6TlhFZ2ZTbk82S3FLS2NoU0NZUGdoSEdLUkYwVzVwNEtmOTlM?=
 =?utf-8?Q?z4TWNJVjLUbe/dVT0MKB3QM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9721fab-c427-47e8-7628-08dbdfc12ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 18:41:39.4081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ug1gEZBZs5i8M0XUH3RzqYxCANigYAYWcqfVx/8dlIZGQshyd9ymJE7BATo+iOFcFjGXpHnRi4PTdGafvTnYiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-9.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uZGF5LCBOb3ZlbWJlciA2LCAyMDIzIDExOjI3IFBNLCBIYW5uZXMgUmVpbmVja2UgPGhh
cmVAc3VzZS5kZT4gd3JvdGU6DQo+DQo+IE9uIDExLzYvMjMgMjE6NDQsIEthcmFuIFRpbGFrIEt1
bWFyIChrYXJ0aWxhaykgd3JvdGU6DQo+ID4gT24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMg
MTI6NTkgQU0sIEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPiB3cm90ZToNCj4gPj4gUGxl
YXNlIG1vdmUgdGhpcyBjaGFuZ2UgdG8gdGhlIGxhc3QgcGF0Y2guDQo+ID4+IEFuZCBJIHdvdWxk
IHdhZ2VyIHRoYXQgdGhpcyBjaGFuZ2UgaXMgbW9yZSBpbnRydXNpdmUgdGhhbiBhIHNpbXBsZSBw
YXRjaCwgc28gYW4gdXBkYXRlIHRvIDEuNyBvciBldmVuIDIuMCBpcyB3YXJyYW50ZWQuDQo+ID4+
DQo+ID4NCj4gPiBUaGUgdmVyc2lvbiBjaGFuZ2UgaXMgaW4gdGhlIGxhc3QgcGF0Y2ggb2YgdGhl
IHBhdGNoc2V0Lg0KPiA+IERvIHlvdSBtZWFuIHRoYXQgSSBuZWVkIHRvIG1ha2UgYSBzZXBhcmF0
ZSBwYXRjaCB0byBpbmNyZW1lbnQgdGhlIHZlcnNpb24gbnVtYmVyPw0KPiA+IEluIHYzLCBJJ2xs
IHVwZGF0ZSBpdCB0byAxLjcuMC4wLg0KPiA+DQo+IFllcywgcGxlYXNlLiBBbmQgbWFrZSB0aGlz
IHRoZSBsYXN0IHBhdGNoIG9mIHRoZSBwYXRjaCBzZXJpZXMuDQoNClN1cmUsIHdpbGwgZG8uIEkn
bGwgbWFrZSB0aGlzIGNoYW5nZSBpbiB2My4NCg0KUmVnYXJkcywNCkthcmFuDQo=
