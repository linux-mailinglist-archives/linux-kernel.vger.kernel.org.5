Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2479BB57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbjIKVbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244431AbjIKUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:31:01 -0400
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5271A7;
        Mon, 11 Sep 2023 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2159; q=dns/txt; s=iport;
  t=1694464256; x=1695673856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qOBecw0N5f+0kGTjODQ/pWk0jFg9Ez/ElhcY3AdF5iY=;
  b=css0ovJFWe7YAf1t8pZd/9FEGuSc88GLUhLIeryptwKKyZMx7cfFENlL
   Wua56soE09mS74lzxJMJ8h7wZzYbKFdT8D+IOreRI+l2ELXinb7M9FtSG
   IuKbISBWXBG8HADEfk2cmwxgr70HNFs4o/RC7IE/PkoMG8ji1G/2BY/2u
   Y=;
X-CSE-ConnectionGUID: 1wACdchoTM6O8Gvcf6m5mg==
X-CSE-MsgGUID: Rdfpu4g2QlO1p+Hu+u6QLA==
X-IPAS-Result: =?us-ascii?q?A0A0AABjeP9kmJpdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZFJ2AlkqEkcxh2wDhE5fhkGCIwOdexSBEQNWDwEBAQ0BATkLB?=
 =?us-ascii?q?AEBhQYCSgEEAQiGGQIlNAkOAQICAgEBAQEDAgMBAQEBAQEBAgEBBQEBAQIBB?=
 =?us-ascii?q?wQUAQEBAQEBAQEeGQUQDieFaA0IAQ4QgX2DYAEBAQECARIoBgEBNwEEBwQCA?=
 =?us-ascii?q?QgRBAEBHxAyHQgCBA4FCBqCXAGCOyMDARCcHwGBQAKKKHiBNIEBggkBAQYEB?=
 =?us-ascii?q?bJsAwaBSAGICAGFOYRNJxuCDYFYgmg+gmICgSsBEgEjhBKCLolHhUAHMoImg?=
 =?us-ascii?q?1yJUiqBCAhegWo9Ag1UCwtdgRGCRQICETkTR3EbAwcDgQIQKwcEMh0HBgkWL?=
 =?us-ascii?q?SUGUQQtJAkTEj4EgWeBUQqBBj8RDhGCRCs2NhlLgmAJFQw1TnYQKwQUGIEUB?=
 =?us-ascii?q?GoFGhUeNhESGQ0DCHYdAhEjPAMFAwQ2ChUNCyEFFEMDSAZLCwMCHAUDAwSBN?=
 =?us-ascii?q?gUPHgIQGgYOKwMDGWQDRB1AAwttPTUUGwUEZlkFoBRugXGCJIEYMx1Klh+uW?=
 =?us-ascii?q?wqEC4wAlTsXhAGMbphwLodBkD6NYZU+hH0CBAIEBQIOAQEGgWM6a3BwFYJuA?=
 =?us-ascii?q?QEBMVIZD44gGYNfhRSKZXYCOQIHCwEBAwmJCQuCNAEB?=
IronPort-PHdr: A9a23:QjA31BPSJfA3RX//fRwl6nfLWUAX0o4cdiYP4ZYhzrVWfbvmotLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgrDmgKUYAIM/lfBXJp2GqqzsbGxHxLw1wc+f8AJLTi820/+uz4JbUJQ5PgWn1bbZ7N
 h7jtQzKrYFWmd57N68rwx3Vo31FM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:rhUFC6vRVhwuQYMjnYqZmAlDzufnVGteMUV32f8akzHdYApBsoF/q
 tZmKW3QPK6NN2H8copyPN+yoBgE6JeDnIBnGlE6rn08Q34bgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0rrav656yAkiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuHYjdJ5xYuajhPs/Pa8Us21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 44vG5ngows1Vz90Yj+Uuu6Tnn8iG9Y+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0HgkmVZCq9oMrLlDmruW4w0bGdEfJndI+I189M9Mdp+N4VDQmG
 fwwcFjhbziZjO6whbm8UOQp3YIoLdLgO8UUvXQIITPxVKl9B8ucBfSRo4YFgF/chegWdRraT
 8kQcyZuaB3DSxZOIVwQTpk5mY9Eg1GmKmYC8wzM+/pfD2779gB/yKWxP4DsfvvTXYZ1gwWF+
 Fvi1jGsav0dHIXPlWXamp62vcfLnCXmSMcRGae++/pCnlKe3CoQBQcQWF/9puO24ma6WtRCO
 wkP8TEvhbY9+VbtTdTnWRC85nmesXYht8F4CeY27kSGzbDZpl3fDWkfRTkHY9sj3CMredA0/
 gaWtvjlDjxojJjLbiKy6Lya8zbvPCdAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdRGyYL
 9ei8XZWulkDsSIY//7kog2f0lpAsrCMH1FlvFyGNo6wxlohPNbNWmC+1bTMAR99wGuxVFKNu
 j0PnNKTqbtIBpCWnyvLS+IIdF1I2xpnGGOE6bKMN8Bxn9hIx5JFVdsBiN2ZDBw4WvvogRezP
 CfuVfp5vfe/xkeCY65teJ6WAM8316XmHtmNfqmKP4YSP8cpL1LdoX4GiausM4bFzhBEfUYXZ
 8/zTCpQJSpy5VlPlWDvHL5NjdfHOAhnmz+OLXwE8/hX+ePOOCHKIVv0GFCPdes+pLiVuxnY9
 s03Cid540s3bQEKWQGOqdR7BQlTdRATXMmmw+QJLbTrClQ9Rwkc5wr5nOlJl3pNxfoFz48lP
 xiVBydl9bYIrSaZc1TUNis5OOqHsFQWhStTABHA9G2AghALSY2u96wYMZAweNEaGCZLl5aYk
 9Ftlx28P8ly
IronPort-HdrOrdr: A9a23:trK2QKsYVJxNAiPdjkobfJFL7skCM4Aji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwSZVoIUmxyXZ0ibNhRItKLzOWyFdAS7sSo7cKogeQVBEWk9Qtt5
 uIHJIOdeEYYWIK6voSpTPIberIo+P3sZxA592us0uFJDsCA8oPnmIJbjpzUHcGOzWubqBJbK
 Z0k/A33QZIDk5nFfhTaEN1OdTrlpngrr6jSxgAABIs9QmJih2VyJOSKXKl9yZbeQlihZM5/0
 b4syGR3MieWveApSP05iv21dB7idHhwtxMCIinkc4OMAjhjQ6uecBIR6CClCpdmpDt1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6jh2f5q8CRfkN5NyMBv/MdTvLq0TtmgDhO6t
 MM44tfjesPMfr0plW42zEPbWAzqqP7mwt4rQdZtQ0tbWJXUs4ikWVYxjIULH/FdxiKtbzO14
 JVfZvhzecTflWAY3/DuG5zhNSqQ3QoBx+DBlMPo8qPzlFt7TpEJmYjtYQid007hdkAYogB4/
 6BPrVjlblIQMNTZaVhBP0ZSc/yDmDWWxrDPG+bPFyiTcg8Sj7wgo+y5K9w6PCheZQOwpd3kJ
 PdUElAvWp3f071E8WB0JBC7xiISmSgWjbmzN1Y+vFCy/DBbauuNTfGREElksOmrflaCsrHW+
 yrMJYTGPPnJXuGI/cB4+Q/YeglFZAzarxjhj9gYSP6niviEPyfitDm
X-Talos-CUID: 9a23:ArKSOW8H+oRuZseBjMeVvxcLM+speX3a8FKOBB+XF21nFrjITFDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3As+GsWw1RJXteedrKKCxJPL6+KzUj2aigEF1Rns8?=
 =?us-ascii?q?/v+7dLW9QJnSA0g2Ta9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 20:30:55 +0000
Received: from rcdn-opgw-5.cisco.com (rcdn-opgw-5.cisco.com [72.163.7.169])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 38BKUrkU013358
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 20:30:54 GMT
X-CSE-ConnectionGUID: RU2RRkKIQiKOI+crfx0lcA==
X-CSE-MsgGUID: gHssNg9fTKSCTrsJI0bpKg==
Authentication-Results: rcdn-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="1750397"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by rcdn-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 20:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG4n9yj+uLnzq5JkO0epxpktXHzCiev7LOttA7hQeRdUQWlO6BjgBvdm/+MwgDh3eNNMcArPCneph6CZBM+AGJqzQX03+lpllzgWxbHA84IvvD3POzsgzFzuMaQg0wwBIiNtHX9z4/8zhkMPjL+uIIHimz0yQ5zyWLh1zw929UIjqSgCvHcpDFUbqmwoTU5qCr3GiMGa7b69N1MAGVkctQ2MD3FvKwEkhnn2CNkWez0TsM4mvyb1Nr1ruG1Qq2OKMInH3Zpxoc7eoftdty6ug7eAq33rSw9GR1O6oqx1iACZIOTPM/4juBUU8KQxkd88UyAl8Uc7caocFTrKCZ6y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMngIspVYXN+DCVNIpiSNsUH72zHPeqGVZCPQMuRtXU=;
 b=jRaM0o6jwVI+hh2AD+lRp29yqB0HhyY9ydTGfWX4xFO82GyJXPZrPSL8UzwYhWJozJyMXjfl/jQgu97j8tNZWBW5ZL2rEoVlCX2h9hO0zDRcIOaFs8Q+lG/gfv7PJt8V7Bw4C221/ZbL/TlznertSyQcCxbAsf51z0w+zGnWKrPA39/jcyle3nt43Hsqbd74AxXLi68bPdGo5Oes7VLDspBB/wuGkjlk0ooR098YzARBAHUykxToXUmFETTGZjd6qzNwrU6IGiDDtE8HekA68dQJwAqXMaNCg550Rw3hamgIRs5RQChzWgJx6GnsKC5FMn5Kae2Jhd//8JP5UP13Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMngIspVYXN+DCVNIpiSNsUH72zHPeqGVZCPQMuRtXU=;
 b=HtEo55zUFvjV/5cnzvFTEzL2aBiAyzGYF/s6v1/sIc44oEDSYBsnfeU2/s+5v002xkCPpAVRx8DG0MV3ZhVEJ0Bl1bpO6XGCT4GvVUGFoBUht1q4A/DR8hYzbBzeLuLqP7CtamYkSvdGlnKxayqYsZwyuKPgpwj2UBkd2Jk61M0=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 20:30:51 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::4877:8f0b:4cfc:d4f8]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::4877:8f0b:4cfc:d4f8%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 20:30:51 +0000
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
Thread-Index: AQHZ0TfGBvu03c46X0eIQ87x36OFma/7kDlrgAUSZBCAAwuPaIAMTfTggAY+CfA=
Date:   Mon, 11 Sep 2023 20:30:51 +0000
Message-ID: <SJ0PR11MB58963740D15862CEFE3D3661C3F2A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20230817182146.229059-1-kartilak@cisco.com>
        <yq1msyezuvm.fsf@ca-mkp.ca.oracle.com>
        <SJ0PR11MB589673606EA6527A478990B8C3E7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <yq1h6oguia0.fsf@ca-mkp.ca.oracle.com>
 <SJ0PR11MB5896D892D85652FDB73915D3C3EEA@SJ0PR11MB5896.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5896D892D85652FDB73915D3C3EEA@SJ0PR11MB5896.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|PH0PR11MB7636:EE_
x-ms-office365-filtering-correlation-id: 2e4ad48f-c8e8-4a59-4d3a-08dbb305fd7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kOCI54upmA4Uuogwm2UeZVo3EarVj9xg8Fn5R1sdwL9xIyeU+OIc+mXLzyJ0EJG+/vT1Fkj7rDFTWpAX4AzWOS76At8FDtfzWf/51+RNJ+vy9lhwGtm3EU6UdMTkgQqhmt7fXsMwoNlCfdCgxUW8HJ09q4VItPhN+X0VImagKfwgcrbWOiSiL8ztKUtmyRUOtuI3UdMK+usKGYGpOihNXpYpFgdCJAg1JttCKshaRF+ZDA5RG7cayzLLq8ZJs+vIiXbgZYUieJ6HbhHmfX0OhEO2OhkgB8X+GQO5QjxlFkhPrc2jxdmI2V+S4S3geAvdNZjC0zVAxoZCyZ/9nC3DhWktjoTXMtM1qqV1EYzCqYpX8E8J4MJV1rBLQWyfuXVyStwEd8brUH0gSd/5i7GjSsxAcq95Z0mqDESw4KKjOhnYc5qSRkguopf3csBKXlw8g9+pOOrv+lW0EvFAejGc7SrU+SeBWVALmZLJskmn6FVaxWcOOWwHzoX3XDU33Y2U5HPnUpeSkVHM09Qy9F1/quJbPaVXfJSTDHreT7KL2PQ+xG84mA9b2R8a9YrvryNW6KMOYo6RtplEN17YTcJrw+BvK9fybr/kQ5P5UJRQ7P8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(6506007)(7696005)(53546011)(71200400001)(478600001)(83380400001)(966005)(2906002)(66446008)(64756008)(66476007)(6916009)(66946007)(66556008)(54906003)(316002)(52536014)(76116006)(8676002)(5660300002)(8936002)(4326008)(9686003)(86362001)(55016003)(33656002)(38070700005)(38100700002)(41300700001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wgj5bcME/GHqZUDbRNgiLkw73nur2Hr6tKa74YaYvAJ2Ccdet3MrBQRFfFGC?=
 =?us-ascii?Q?nG2D9N84+Xeh7WTHrksa6Bxglh7LqdPxZut6G7Ffl+wyGlMVwG1beuNOjL0H?=
 =?us-ascii?Q?x4HEOOFt4K1UvtgVc/zcQLMM6wscuVEe4YC+9JOXBoF9T4nz5p3p5TgwItID?=
 =?us-ascii?Q?16g5BMEtGgS7OK5N00X5ZPRZlrypIcp2+XXPkqU2mZagCJmjaB4XZtHs69f1?=
 =?us-ascii?Q?fbceTL7gegRSjeoWthCqkSvGIB2ApsxeZZh77o0ToF5L4/xzh3C3M+1VJQ/1?=
 =?us-ascii?Q?hpZBIiuVEPA1VU+BXzMae1jVbyB4rj9x7RP/C2aOUOVpM7mUU16xm5LziU1l?=
 =?us-ascii?Q?zJBhY2GsMtc0i59vwHTTLQeo6SokRLprC5/J4djW2pOGA7qdW34tM8Q7blzU?=
 =?us-ascii?Q?cQD/HgbbsDFDBF4wdiM9PZGfOvf8YR/mLx1TuwIXM5jCThOSlKKAalXzIgS6?=
 =?us-ascii?Q?gB6a8JAv69PdgbI8LYPWiTX7uVtAJZ1CSOCIqmZ00dsonVgSaH/Vskp104lr?=
 =?us-ascii?Q?wpCNYj8PLYXVx4IaMco5i9uw27ub6uzXiC1v7lq5KuKsM2/131S8bg0q4j36?=
 =?us-ascii?Q?ES5jyI4Q61pixKE+w4XoFG7SaJ36LtpYuDIyDo7WDBvs0rkOnuZAPSeFt6iZ?=
 =?us-ascii?Q?O13uc5Za8dBfgR5mlmmBFmdfNthO6pYKUFsy7LsOC6G0YwwZzjJF1Q5OUOV2?=
 =?us-ascii?Q?qGP7k45xaPE/mTlNzdBALHkqflWK0qh1hILD6ZOc0h8Y/8HY5+xOMHlRwydS?=
 =?us-ascii?Q?ltbQ2k6x+jLXG2Bye5dd+kkqfV9rOk1y4hHcx18AvkBxADoA8WvGesp5KTdn?=
 =?us-ascii?Q?w1q/CZ0dQxVGDgJfPV/4m+GS46su84Q2k2FB5+/tiVa76UfR9TrNGiwN6qAE?=
 =?us-ascii?Q?85pe3mqlPpNjnB9nk0G6aBAgpwvF/U28SWLVGj79Mi3x8ma0As96OSwzPJfr?=
 =?us-ascii?Q?AYzmxl+RlgxiUewme5w69BfOzl95fc2rbhMPB+VX0vPwv1gbG75AWmqdMFWl?=
 =?us-ascii?Q?AlOyt767fYDDdQBx5s5laMqiClT28S+X1+NI0O7UrUGbziJqIn9g2RWGP9yv?=
 =?us-ascii?Q?4apAFnJjEIIIKdyMHhDzYXjOKeQEQQyvCeEcFRmv8eyTndLY8yHvNe9N1/hB?=
 =?us-ascii?Q?yC8RL5he/T8UCmwBS4Zllat3j5BYo1WtLUIJl4s/Q1XPBGJWmHIFwyfOVqhb?=
 =?us-ascii?Q?b0FZ/PKOmTgNd5xFdOqkeo2GNLYZMXaRzKgTaZXrxis6l7wxS3WGTGKE49CT?=
 =?us-ascii?Q?Cn+/3iGWraJTIUsmcSePqVVVd9JgPCAruHcUCApi5O1DF360JugLkyDiAicL?=
 =?us-ascii?Q?iM8NBE7gWJO4fF6r1Arf10RFgxwPYYV4ZK9aYo6xKTp3OYReLKagMChv4T7u?=
 =?us-ascii?Q?v9wRF1Bvyn/LQZkvLM8A66taXvVz/0x5BM9qBoC4uRUimCTWAEPxSSGhhEsV?=
 =?us-ascii?Q?Fu78oojZkJqeZYpLlVs/XWiG8rzOvuTSGiW8TsqAVjP7XVeLwNSr0kuoHPOE?=
 =?us-ascii?Q?BnIgypSOqeqOb7CUSzuqpDmZ/gXxxqUoSPOdtgmm72A/es7/jvKUWaz2yXHt?=
 =?us-ascii?Q?LjyOZxCRd2jjayjSqQrEAU2B9XL82mlGCE2atCCHlHKsildDJCPlV6tmKGmi?=
 =?us-ascii?Q?lO1JrStEmQLjRJGMjpRcBN2RY41r6cFCgRFEotYa9OKe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4ad48f-c8e8-4a59-4d3a-08dbb305fd7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 20:30:51.1728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFOHc9UgCT9Khx0sGoxSIgTyqNBVGEXzL3t24dxFIkBZviKo7JjZB2BBZrCaKcacP5/1HBQvvzC78X9Qb6BrMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7636
X-Outbound-SMTP-Client: 72.163.7.169, rcdn-opgw-5.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

The fix has been merged into Linus' tree.

>> You can request a stable backport once the commit is in Linus' tree.

Please advise how I can request for this.

Regards,
Karan

-----Original Message-----
From: Karan Tilak Kumar (kartilak)=20
Sent: Thursday, September 7, 2023 2:09 PM
To: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Sesidhar Baddela (sebaddel) <sebaddel@cisco.com>; Arulprabhu Ponnusamy =
(arulponn) <arulponn@cisco.com>; Dhanraj Jhawar (djhawar) <djhawar@cisco.co=
m>; Gian Carlo Boffa (gcboffa) <gcboffa@cisco.com>; Masa Kai (mkai2) <mkai2=
@cisco.com>; Satish Kharat (satishkh) <satishkh@cisco.com>; jejb@linux.ibm.=
com; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: RE: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id

Hi Martin,

Would I receive an email when the patch has been applied to Linus' tree?

I just checked out master branch from this repo: https://git.kernel.org/pub=
/scm/linux/kernel/git/torvalds/linux.git/
The fix has not been applied there yet. Am I looking in the right place?

>> You can request a stable backport once the commit is in Linus' tree.

Can you please let me know the procedure to request for this?

Thanks,
Karan

-----Original Message-----
From: Martin K. Petersen <martin.petersen@oracle.com>=20
Sent: Wednesday, August 30, 2023 6:13 PM
To: Karan Tilak Kumar (kartilak) <kartilak@cisco.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>; Sesidhar Baddela (seba=
ddel) <sebaddel@cisco.com>; Arulprabhu Ponnusamy (arulponn) <arulponn@cisco=
.com>; Dhanraj Jhawar (djhawar) <djhawar@cisco.com>; Gian Carlo Boffa (gcbo=
ffa) <gcboffa@cisco.com>; Masa Kai (mkai2) <mkai2@cisco.com>; Satish Kharat=
 (satishkh) <satishkh@cisco.com>; jejb@linux.ibm.com; linux-scsi@vger.kerne=
l.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id


Karan,

> Do I need to send out a patch request to apply this patch to=20
> 6.5/scsi-fixes?

You can request a stable backport once the commit is in Linus' tree.

--=20
Martin K. Petersen	Oracle Linux Engineering
