Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9078078BD00
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjH2Cpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjH2CpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:45:13 -0400
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44903CDB;
        Mon, 28 Aug 2023 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1216; q=dns/txt; s=iport;
  t=1693277067; x=1694486667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R0xq5kcAgd101oHwEsgYJWJAPJaFa6AetGFBjwUxkOk=;
  b=cqS8xbQXjBdBmS4exfihnfhvmkRy+kbmhfXF0IXl2ZJ0yhAJQ+sOCvgn
   I1nzjjuYomcgyw/6aTo2G5AJFES5TSzUVx118jX3KijnK9jMbp3ZnYuKp
   XZIc7dI2t8ccKUhTmiomyBF5jXEDe9B0VyVCF+qw0oy+XnyvAUW9l3vBm
   Q=;
X-IPAS-Result: =?us-ascii?q?A0BPAAAnWu1kmJNdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZFJ0WyoSRzGHbAOETl+IYgOdfBSBEQNWDwEBAQ0BAUQEAQGFB?=
 =?us-ascii?q?gJKAQQBCIYRAiU0CQ4BAgICAQEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBA?=
 =?us-ascii?q?QEBAQEBHhkFDhAnhWgNCAEOEIF9g2ABAQEBAgESKAYBATcBBAcEAgEIEQQBA?=
 =?us-ascii?q?R4BEDIdCAIEDgUIGoJcgjwjAwGedAGBQAKKJniBNIEBggkBAQYEBbJsCYFDA?=
 =?us-ascii?q?YgFAYl9JxuCDYFYgmg+gmICgUcbhBKCLoluhUcHMoIpg16IeCqBCAhegWw9A?=
 =?us-ascii?q?g1VCwtjgRWCRwICEToTUHEbAwcDgQIQKwcEMhsHBgkXLSUGUQQtJAkTEkAEg?=
 =?us-ascii?q?XGBUwqBBT8RDhGCTCs2NhlLgmYJFQw0TnYQKwQUGIEUBGwFGhUeNxESGQ0DC?=
 =?us-ascii?q?HgdAhEjPAMFAwQ2ChUNCyEFFEMDSAZLCwMCHAUDAwSBNwUPHwIQGhkDRB1AA?=
 =?us-ascii?q?wttPTUUGwUEZlkFoCqCMYF7d4Ealh+Zd5RkCoQLoToXqV4uh0GQPaMfhHwCB?=
 =?us-ascii?q?AIEBQIOAQEGgWM6gVtwFYMiUhkPjiAZg1uPeXY7AgcLAQEDCYkJC4I0AQE?=
IronPort-PHdr: A9a23:2jsN+h8nWT53X/9uWO3oyV9kXcBvk6//MghQ7YIolPcUNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8ERHER98SSDOFNOUN37e0WUp3Sz6TAIHRCqNgNvOuXxE436hMWs3Of08JrWME1EgTOnauZqJ
 Q6t5UXJ49ALiJFrLLowzBaBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:atHqGKgbIWQouNzGkC6RJRj1X161cBAKZh0ujC45NGQN5FlHY01je
 htvDGuFa/qIMGD3KI8gatmx8x4F65KGmoBnTAdp+y48RXljpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKkYAL/En43HVUMpBsJ00o5wLZp2N4w3bBVPivU0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pDTU2FFEYUd6EPdgKMq
 0kv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOjzAazhHe3JrXO9JGREAOug+wvOl7l
 s90hceRQFcxPJX1zbF1vxlwS0mSPIVc87PBZHO4q8HWlhSAeHr3yPIoB0YzVWEa0r8oWicVq
 rpJc3ZUMk/ra+GemNpXTsFvj94/Lc3iP6sUu2prynfSCvNOrZXrGv2au4YAh29q7ixINbGFS
 9M3cRdrVQrvc01jOlMSN6Jkzfj90xETdBUB+A7K+sLb+VP7yA13zaioM9fPfNGObdtak1zep
 W/c+Wn9RBYAO7S3zTuD72LpneTUnAvlV48IUr617PhnhBuU3GN7NfENfUGwrf/8gUmkVpcGc
 gof+zElqu4580nDosTBswOQ+lOD5y8mYvlpGbMg0THW66OE+wShPz1RJtJeU+AOuMgzTD0s8
 1aGmdL1GDBi2IF5r1rArd94ShvvZ0AowX8+iTwsFlRavoGyyG0npleeEYY5Sf/dYsjdQGmom
 1i3QD4Ca6L/ZPPnOo2h9lzBxjmrvJWMF1dz7QTMVWXj5QR8DGJEW2BKwQaAhRqjBN/JJrVkg
 JTis5PAhAzpJc3V/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB43Y51eJWC1O
 x+C5F05CHpv0J2CMP8fj2WZVZxC8EQcPYiNug38N4AXOcEhKGdrAgk3PhTOt4wSrKTcufhvZ
 cjEGSpdJX0bEq9ghCGnXPsQ1KRD+8zN7T27eHwP9Dz+ieD2TCfMEd8taQLSBshnt/nsiFuOr
 L5i2z6ilk83vBvWOHeHqOb+7DkicBAGOHwBg5cOL7LSc1I7RDFJ5j246epJRrGJVp99z4/g1
 nq8QURfjlH4gBX6xc+iMxiPtJuHsU5DkE8G
IronPort-HdrOrdr: A9a23:YpPO3qEiBaGJeMKgpLqFrZLXdLJyesId70hD6qkvc203TiXIra
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
X-Talos-CUID: 9a23:to9QxG2s7SUM9GJeRulX47xfQO0iK0zn9VTpKRGiMFYyabTFUV2owfYx
X-Talos-MUID: 9a23:Ef2RawS78KKvhrhkRXSr3x17Gt9F552wJ1BdvZUCvva0b31vbmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 02:44:15 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 37T2iFEx022679
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 02:44:15 GMT
X-CSE-ConnectionGUID: BfGUZHzARyCKGEfldeifOw==
X-CSE-MsgGUID: URDwDC/kSsqFJOyygX5iFQ==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,208,1688428800"; 
   d="scan'208";a="1056665"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 02:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBkGoHt6r7gx6dhMOu+GoO7sRtZdnIzmpiiK7pienQvX5n6K0vDzZc87wmtnVwiddkhAu2OzOkpYoa1iEdz7r5OUyLdddxtqTAgTepkBW1DnmMW2R2JTX16i9W1IhpbhxXQTx+Oo/4m6WO/gCxzqVbV/wVU5InNll0u+HpXtEM9Bei7BkzLJ7Lr65/12DLpUXZi+LTJPNxkxjO9xaayI6ShyY3/uF4bt6eSQDlhwLQ9Q540UDi/GFG+VxN+4Dqt18p8qiTVXYaZiIxQZdTzWBi/08PiFeYV0o2aSEi3J3Zuc1NwlWJUNuImLU29wAasOIEvgyr/KvSYVRx6DS56T/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWuQOeyyIEOwbgr8GZGTx2vEqRrZBREFE7Zs3JcnNxE=;
 b=F01TSIJU6wM2meawosHlpkV5cxoholjV4wYcVASh4ptMULYC7/Vkx/8aOMu5gNulY/jJ42V5NzwiWxMVmw2yWpZMn37RXSOSUdKf/LoTKzazyTVFh4MQq4uenqerK3Z9fSAuc7U2X9ISA2I6hiBkNlJ5Ad82dQS/FOz9k+lMBbTvFrMaxfqcRgScp7iwAJzYimVJTLBFvntWKzX6EoTcXr+UHce7VT888Nz/x6y9rCiD+xikUFVnxgPofIkDD0bPeXtSVdUWkvUHcL3javh4Ye1TxUsV+wkjKaAEenP0eN7n5zTNiYdD081O4vuC1rg9oVPGgk7R9dft0WXc011V+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWuQOeyyIEOwbgr8GZGTx2vEqRrZBREFE7Zs3JcnNxE=;
 b=Gvu9y5FyOuY8HtQFOwSdu7do6Ab2e8Z2kXyRmk9N4nOZF5WLHdaS8tyedKdM+uS8lhL9vC7e5Yam7bpkLwbLgFm2ee1PPAfQAd2n58aRHbppoCVgIH7v6DQHXmLO8R7rwAE45V5rlGiAva73Bff0CeVjW+EvjcO30GNE8Ig0qg8=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by SJ0PR11MB5038.namprd11.prod.outlook.com (2603:10b6:a03:2d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 02:44:13 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::9ea9:5b30:8472:bae4]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::9ea9:5b30:8472:bae4%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 02:44:13 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id
Thread-Topic: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id
Thread-Index: AQHZ0TfGBvu03c46X0eIQ87x36OFma/7kDlrgAUSZBA=
Date:   Tue, 29 Aug 2023 02:44:13 +0000
Message-ID: <SJ0PR11MB589673606EA6527A478990B8C3E7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20230817182146.229059-1-kartilak@cisco.com>
 <yq1msyezuvm.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1msyezuvm.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|SJ0PR11MB5038:EE_
x-ms-office365-filtering-correlation-id: 5b384c33-73e3-434b-f588-08dba839d464
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Ycq94SR+sUnQiZDebkL52+MY6dKo2tdSnnuqYO6s/JllGq8j4dJNoshAeykfqIZhYt9+TsoW6IZ+mQR+BfEDvQiqWQZyEryVQ/CHHYYdEnj73F7WBS8AeCgQCQaKjF82rBkr4XkAn9goxaqUZCY0QXIt04wO/AxC/o5iZAnRfwEBnyjxT3Dc2IHYWLR0uewVyciha7r+R7iuhTfOYJdDyEo0rMBFZGLtzT/fYEFCu4mITEpyUngkXlcGu0j3CSi33D8Q3yOiTlF6plQdpydV1e9kV5DGNKYDnSCPyq6V8KULSw2ne72Y8G2gTJ6urzagc+RBnCqXtwHSIC33niUEJBM1ASNubGOuQTKXJtGdPuIf3kNlQrqpjxQaeO5uXs0wup9gxsf9UdgtU2aQHub80ZEsBYCnTICv/kUJkhAoihWW4O83WBvT2bSPg0gCWGyTCLHzgsEJbIC0rcUjSt5Gi3qITqvqLW1ZtNFgjnNQ4GMWceOXSfo8qr419ANFPsxYQwkMg3ogUKiCpz35J3bzDSgINCs/nfWqrgUJSFz4HFnfIQyudOCCq6efmngL4DkwHoLKn8xehVCrQEU0l/Oq0tyESd/OshCHQYClY/q1EdfA7KrU5rd+DRdU1BfdhJP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(316002)(2906002)(6916009)(54906003)(64756008)(66446008)(33656002)(66476007)(66946007)(76116006)(66556008)(5660300002)(52536014)(41300700001)(7696005)(6506007)(53546011)(9686003)(55016003)(4744005)(38070700005)(38100700002)(478600001)(71200400001)(83380400001)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O4gN/76TMn2dG7snRlDYeD5I1fS0H5+iBvfpKb8gcCm3jiBxlncIfDeMdkgA?=
 =?us-ascii?Q?VGpqx3+yiIHULVU7iIpKGMguGt+4crHQbqjJtyAVhUfH4kkgeCTgLlIiU7yL?=
 =?us-ascii?Q?laWm3JWr8TgZfPU/HELXENwkFg7gnrtCFGE5omMeUqDqYs86lo961RQEgwPj?=
 =?us-ascii?Q?nomd3nP4GBidIpOEmzy/M0IXyc+pNbhTocOhHzF+g8czPjAAhHPyE6rq3zT9?=
 =?us-ascii?Q?E2L9UBco3kaleC0BaBElgupCu1wPtHV+9q2h/qLBosKRe0ktbaF5JrA2NdvU?=
 =?us-ascii?Q?h52mx3bo9zNk4FrvQc63eypSh5pIvTso7XJXkZ4t88nSn/bSDecDN/x6ADEs?=
 =?us-ascii?Q?GKAlJJo6cSmGX2Uoy5TYJ7iXAPjvqlP5YFRLsPXf3/idO1T4Qln6Xsq6gVYG?=
 =?us-ascii?Q?wFwE7ELeBF80Ely2XZfAWnIPmzcxTU03k1JpfnY9RyTcexCMseVP8gfT914m?=
 =?us-ascii?Q?Vv5ZblB7e1WtMu3Y+igukrLrTrvvddKapxqkPUDxL3f7V0kqztln7dIQxrV1?=
 =?us-ascii?Q?OttGQikWcJzEta6YSBQ1GZytXyjyZYp63cFIPz+5SbybecU6YyBP9NhPtNb/?=
 =?us-ascii?Q?PfbNyElJKnX09ci5sCj4GvwEbyN1Cf09qoh1ThMO9AUkeMHvvpH52V4rt9eh?=
 =?us-ascii?Q?/hod3Bb6L+UT5KQ+iru3XzyiuJ/yhEzffSnsX7Ks96sypnkT7YHfe1fAd9gm?=
 =?us-ascii?Q?H11J9kzUMTuyhpLnmgYQ9WXIngNrYWLxI9synU1Qh4bRA7ejhGzpbGLX44Sr?=
 =?us-ascii?Q?BQ8Aj5w2RdVUXvWTw0OvgHgwqxp9kkDEQIlVUW5QeAnEXgrwMzIT0jG0q9k0?=
 =?us-ascii?Q?6tGvlvGPwsnD+E9RGQ574uctrdWwb516rK/QWAbsvchmS5/fKx/rdwOgsjlj?=
 =?us-ascii?Q?/qBY/I4oJJO7y89qwKi878PCOCUM3rI5agl1YcnFpq2vpK6dJU0zss1yZdqk?=
 =?us-ascii?Q?VIc5fbLQjhHKKA+/hWmOl0x8iG8OGOBNnA+eIGuXP60SgWnVo6dK6jPHONPo?=
 =?us-ascii?Q?laVQIPM2CKyK0yfeXlz0eVaycopQGA8iPU8fqpnzVZzpt9BlBjwQtLhUd0ky?=
 =?us-ascii?Q?t5oSMHY4TLDIxpZtSAr57d89YHvgB/iHba5IOpqtlVd6axxdjlkDEljmGse/?=
 =?us-ascii?Q?6hreiCHTYucHXhBspz1/Hn9MCZLMgeywohc2kmCMY05D76VCjUMUeScZ9QTl?=
 =?us-ascii?Q?NekqffvSPoB4OrKdhuChw3bHJV+LpwudVZPc1bnuk+VmIOFf4uNJCXgdMqQm?=
 =?us-ascii?Q?OBSTbQ0voMBQEIGk4m8D9tWoOlmmRFIsadOA8xsp0n67RdpE2SBQ2kXLWfMB?=
 =?us-ascii?Q?XOdwIVzgs3fhYiIEX1TDf1+sEOER0hA/N0b29ylRwNmR16thlRzySt0mq+q8?=
 =?us-ascii?Q?LTWKL4hSr0BF2YuAcfcicOlxuY2Na9lrl4SGHz1svK0Nm31kGgchvRl8Z9T5?=
 =?us-ascii?Q?XAwrdzElPNp33BXj+kRaxFlCsmBUmLGad1zr/EJzBRX9pSvHZVr4GMBELOJS?=
 =?us-ascii?Q?4OvN4qI7n9t+7y/qQc04BVV5IymShCTsSWoiComCa3H4IRjc0vC+/E3gYvdZ?=
 =?us-ascii?Q?mATOtzONBRZgVjIfILAB3O4u9fk9ThAbXeQhUFuHXB4l+S6wbAtGfszRwhkF?=
 =?us-ascii?Q?Lq7sjPqB+pGwXYBfWRr63gp/wEHvpgM/6meONpCXt3NQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b384c33-73e3-434b-f588-08dba839d464
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 02:44:13.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXU5E/hpbjp0ykrby1JVSn8FpQA1i2xwIsDTPY0fnPQNVE2E190D+NKgFE5J7VtlGHOhDfvLA9iAwUJE0H736A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5038
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Martin.

Do I need to send out a patch request to apply this patch to 6.5/scsi-fixes=
?

Regards,
Karan

-----Original Message-----
From: Martin K. Petersen <martin.petersen@oracle.com>=20
Sent: Friday, August 25, 2023 2:16 PM
To: Karan Tilak Kumar (kartilak) <kartilak@cisco.com>
Cc: Sesidhar Baddela (sebaddel) <sebaddel@cisco.com>; Arulprabhu Ponnusamy =
(arulponn) <arulponn@cisco.com>; Dhanraj Jhawar (djhawar) <djhawar@cisco.co=
m>; Gian Carlo Boffa (gcboffa) <gcboffa@cisco.com>; Masa Kai (mkai2) <mkai2=
@cisco.com>; Satish Kharat (satishkh) <satishkh@cisco.com>; jejb@linux.ibm.=
com; martin.petersen@oracle.com; linux-scsi@vger.kernel.org; linux-kernel@v=
ger.kernel.org
Subject: Re: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id


Karan,

> sgreset is issued with a scsi command pointer. The device reset code=20
> assumes that it was issued on a hardware queue, and calls block=20
> multiqueue layer. However, the assumption is broken, and there is no=20
> hardware queue associated with the sgreset, and this leads to a crash=20
> due to a null pointer exception.

Applied to 6.6/scsi-staging, thanks!

--=20
Martin K. Petersen	Oracle Linux Engineering
