Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380F80ACD2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574660AbjLHTVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbjLHTVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:21:20 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 11:21:23 PST
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE719AC;
        Fri,  8 Dec 2023 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=893; q=dns/txt; s=iport;
  t=1702063283; x=1703272883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eHlUu4hgCc9skp2PT8ptv7rDeKvJAp266AnLDIdhsYc=;
  b=C5CaobbXoyO1vbuWRnSDmU+Qa5fShlgNboSop0wzhS9S8xmKBjXL/1lZ
   KMbIbSKstDPBwDlH5QHnYejnObh1DOjEMbWPul+gAlnkesNOD8cWrmn3x
   zQ24JXQomsXIrvPtzPYcBf/E+oeD7BA+j1a7O5VHRWq59KIlkNaw0oREf
   Y=;
X-CSE-ConnectionGUID: Sdyv051FTPuou3N66UDR6w==
X-CSE-MsgGUID: Wv3uAEsyTdKDofQTQqB2PQ==
X-IPAS-Result: =?us-ascii?q?A0A1AAA2a3NlmIcNJK1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ5XCoSSIgeA4ROX4ZFgiWdfoF+DwEBAQ0BAUQEAQGFBgKHLAImNAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBBgEBBQEBAQIBBwQUAQEBAQEBAQEeGQUQDieFd?=
 =?us-ascii?q?QiGPQEBAQEDEig/EAIBCBgeEDIlAgQOBQgagl6CXwMBogQBgUACiih4gTSBA?=
 =?us-ascii?q?YIVBbJ5gUgBiA8BihcnG4INgVeCaD6ERYQSgi8EiRkHMoIhg1GQX35GcBsDB?=
 =?us-ascii?q?wN/DysHBC0bBwYJFC0jBlEEKCEJExI+BIFdgVIKgQI/Dw4Rgj4fAgc2NhlIg?=
 =?us-ascii?q?loVDDRKdRAqBBQXgRIEagUWEh43ERIXDQMIdB0CMjwDBQMEMwoSDQshBRRCA?=
 =?us-ascii?q?0UGSQsDAhoFAwMEgTMFDR4CEBoGDCcDAxJJAhAUAzsDAwYDCzEDMFVEDE8Da?=
 =?us-ascii?q?x82CTwLBAwfAhseDScjAixCAwkKBRICFgMkFgQ2EQkLKAMvBjgCEwwGBgleJ?=
 =?us-ascii?q?hYJBCcDCAQDWAMmJgNEHUADC209NRQbBQRkWQWjXAmBboICcZYjrwMKhA+hQ?=
 =?us-ascii?q?heEAYxzmRKYQqgvAgQCBAUCDgEBBoFjOoFbcBWDIlIZD445k1h2OwIHCwEBA?=
 =?us-ascii?q?wmKYQEB?=
IronPort-PHdr: A9a23:DrvNHxy0LjsZ3brXCzMRngc9DxPP853uNQITr50/hK0LKeKo/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YAl8PPj0HofRp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwPnIJ4I6Atyx3E6ndJYLFQwmVlZBqfyh39/cy3upVk9kxt
IronPort-Data: A9a23:IFfdwagFUO186PPRsnR1OyzKX161QBAKZh0ujC45NGQN5FlHY01je
 htvC2nSa6nfZzOkKtEgYd6x8xwE6MSHz4VlGQU4qilnEChjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1H1dOCn9CEgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZWDULOZ82QsaDlNsfrT8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 woU5Ojklo9x105F5uKNyt4XQGVTKlLhFVTmZk5tZkSXqkMqShrefUoMHKF0hU9/011llj3qo
 TlHncTYpQwBZsUglAmBOvVVO3kWAEFIxFPICUOzoNLLkhToT0PxxOg1Kh9oAKEipPkiVAmi9
 dRAQNwMRhmHg+Tzy7WhR6w2wM8iN8LseogYvxmMzxmAUq1gGs6FGv6MvIQFtNszrpgm8fL2Z
 MMDdTtrZRfoaBxUMVBRA5U79AutriCuKWII9w3I/MLb5UDs0lds+ZX2IebZWfCNS/xpp1+y/
 Fr/qjGR7hYyb4HHlmHfrRpAnNTnmSL9RZJXF7Ci8PNuqEOcy3ZVCxAMU1a/5/6jhSaWX9NZN
 lxR4SE1rIAs+0GxCNrwRRu1pDiDpBF0ZjZLO+Q+7AfIwa3O7kPDQGMFVTVGLtchsafaWADGy
 Heyk8L3XWE2noGtVHWArZHK8w6eA3YKeDpqiTA/cSMJ5NzqoYcWhx3JT8p+HKPdsjETMW+pq
 9xthHZm74j/nfI2O7OHEUcrag9AS7DASgozow7QRG/gtEVyZZWuYMqj7l2zARd8wGSxEAPpU
 JsswpT2AAUy4Xelz3LlrAIlR+/B2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RCL4FIOv88MYyTyPcebhr5d7ex0lMAM8vy7D5jpgiZmO8EZmPKvpXgxOhDIhwgBbmB3yPFjU
 XtkTSpcJS1HUfs8lmXeqxY12r4wzSd23nLIWZ3+1Fym17HYDEN5up9bWGZimtsRtfveyC2Mq
 o43H5LTm313DrakCgGJqtF7ELz/BSVhbXwAg5YJJrfrz8sPMDxJNsI9Npt9It0+zv8Oy7+Yl
 px/M2cBoGfCabT8AVziQlhoaajkWtB0qndTAMDmFQ/AN6QLCWp30JoiSg==
IronPort-HdrOrdr: A9a23:p5v9Ya1JhCxdvTMWSy0KjwqjBf1xeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6K690cm7LU819fZOkO8s1MSZLXjbUQyTXc5fBOrZsnHd8kLFh5RgPM
 tbAsxD4ZjLfCdHZKXBkUeF+rQbsaS6GcmT7I+0oQYOPGRXguNbnntE422gYzRLrXx9dOEE/e
 2nl7J6TlSbCBMqR/X+LEMoG8LEoNrGno/nZxkpOz4LgTPlsRqYrJTBP1y9xBkxbxNjqI1OzY
 HCqWPEz5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwiy6zDb4RG4GqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg6jAz8HXvoGXowkcL4PaJBg7SOfAxwb6xQSGprHbIe+sMlp
 6j6ljp8qa/yymwxRgVqeK4Dy2C3XDE0UbK2dRj/EC3F7FuKYO4aeckjRlo+FBqJlOg1Kk3VO
 ZpF83S//BQbBeTaG3YpHBmxJi2Um00BQrueDlIhiW56UkeoJlC9TpR+OUP2nMbsJ4tQZhN4O
 rJdqxuibFVV8cTKaZwHv0IT8e7AnHEBUukChPeHX33UKUcf37doZ/+57s4oOmsZZwT1ZM33J
 DMSklRu2I+c1/nTceOwJpI+BbQR3jVZ0Wm9uhOo5xi/rHsTrviNiOODFgojsu7uv0aRtbWXv
 6iUagmdcML7VGebrqh8zeOL6W6c0NuIvH9kuxLLm6zng==
X-Talos-CUID: =?us-ascii?q?9a23=3AYPVUJWonjGl5C9o3NjQeUL/mUfspY2OFkS7+H3e?=
 =?us-ascii?q?lDnsybuPLdHOqprwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A2bJ+tA/t34639LOpjtD535uQf/h2uLmHJVscrZk?=
 =?us-ascii?q?ll86KDBBJIh3HtA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by alln-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 19:20:13 +0000
Received: from rcdn-opgw-3.cisco.com (rcdn-opgw-3.cisco.com [72.163.7.164])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 3B8JK561024250
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Dec 2023 19:20:11 GMT
X-CSE-ConnectionGUID: rBWI5UibRN+RvfR3Th92uQ==
X-CSE-MsgGUID: SZmWdgmdS+qWU/jVxcGG2Q==
Authentication-Results: rcdn-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.04,261,1695686400"; 
   d="scan'208";a="3639681"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by rcdn-opgw-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 19:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJVH5HuikVSUqN7hXXKpNnDwDnf+KIjRermBVfF7DCbllUgYtNr6ph7IJzsdJhomcECYTvPTFwZk1fB1otO2w7hy/fzEDC3N70EW2wi6eBQ84fjdwNmSX4E6dYJclPKBHKj5PPobWSfkDYrfcUu3803NVnabDXDzJWKUo2OuIt1asWEC+qzjHe9xkKr/oUjYubUIi1qUJPSpZSI+UoYu2vVOkaRKgo8mTbXCimmh1tKzb9Y0LVg/5a0Nk56Y5WOXaoZ+VQKCKhzBCIKzu/wZmwOS2Qp6wl2swWqa/YgbONdtDGkF36+XoQxhTcLC2/2+FG8E02Azo9KwnSxp1hL1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHlUu4hgCc9skp2PT8ptv7rDeKvJAp266AnLDIdhsYc=;
 b=DwUe2PZPloTQqw3rY+2y6dVHH3I0vDWxbHT5etwCXaboaBWUNK/oDFKc1XDLucnof7oUvOBz+lL8OdZnDKIgnaeSYZiTHt27+zfLxdLrfXraeylprfU5S45hvDeSJOwuGypXuuKQONEcxHzqw9q8ZjnhpaVV9WQe7iQLdvCu68O6IoYCjgYgwtV4t1Cwv3IFGvMNvEIVT4nu87YgF4YofLMnEqm28tCT63nsMblAaADaWWsaJQX1Al9L8wRHvFKeTQhHxWj+l02CqoKFRh/PBW2n5AaC/0OWwqdegSuMDDriijl3Wgc+6vo3BtpbsphsXNI6ThZzywkNhw0rrdbxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 19:20:03 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 19:20:03 +0000
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
Subject: RE: [PATCH v4 00/13] Introduce support for multiqueue (MQ) in fnic
Thread-Topic: [PATCH v4 00/13] Introduce support for multiqueue (MQ) in fnic
Thread-Index: AQHaIzW8spPreXFLkUWvW1Zcp94ae7CbnT3QgAAJcBCABBTCFoAAFKfw
Date:   Fri, 8 Dec 2023 19:20:03 +0000
Message-ID: <SJ0PR11MB5896A7AFDE1DC8D1C7AD65FCC38AA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231130023402.802282-1-kartilak@cisco.com>
        <yq14jgwm3gz.fsf@ca-mkp.ca.oracle.com>
        <SJ0PR11MB5896728CD14BD099A273C98BC384A@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <yq1ttosk2n1.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1ttosk2n1.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|PH0PR11MB4837:EE_
x-ms-office365-filtering-correlation-id: 91797011-c231-4381-aaa1-08dbf822adf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DW90Oq7g0uIJb+U3c/zvOvOgA5ozzuI8ez5w+GQF5tusg+zYumIJpzJnbuhykrR2K0xa36t3ZhDE8DZVCtoDd8KDCyygbyHB+B27vFr8GhFg5Y5BS+hfTJXkED7FxB1+DXbjPPf/YMfJ1r7aMgkyrfqPayu/N7MjEC+piiJJ4+dN0odllrNGWibItaigGVKxAfWKgzRVhZHMxcSiK+ODZ1lJHF88Zl99/leSlvsWFk/35rGKVNMgiNb+MHjEpBZWo651CmV/7Y1wq7ho1VCvDZT1ZyV+H0D1LQzuc5HrCgZytTB2vHPhJE+go5W4kE9fiBv1VZW7cns1dfAhocfO1sx51SxJgKxTDcI6yZ/kBHSfaHoF/1+iAQjlH3Yp94qwgpbB2ScMTKxpDGiBZexhiKr6uSXUyX/BTSluq+ddFvqSzkgl2QmOA3cnCnox8bjBcEb7kliHxgu1bo4lGxevFHn6lfCMOTdA9ugx0/hpa3m3VhnOHM3xA7G/NcDTZy7w1XoqvBymo2omleXtBhzNso7KBQTRpxF62T0or2tN23SMeGFmbrcnHmdqwz4Ji1vf9k1kwsPA5fa+cELXNPYN13JO/TNERlhqhbTn0pW8+WMWNhBsO0WINe/cGPDOnCf9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(122000001)(33656002)(71200400001)(7696005)(6506007)(478600001)(55016003)(38100700002)(9686003)(83380400001)(53546011)(5660300002)(4744005)(8936002)(2906002)(8676002)(86362001)(41300700001)(4326008)(52536014)(66946007)(38070700009)(6916009)(66476007)(66446008)(64756008)(54906003)(76116006)(66556008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C1ay5zOIZ4Lb54BtrKg+y4YF81YNknSvpzJ78RscMX8TAR0zfYhsd1Dv7+tW?=
 =?us-ascii?Q?EnXq1utqYEL1f1+B3xhghewv2gpAN6cO/AyRxmWoAXFIn5bMUSSklWVCFILV?=
 =?us-ascii?Q?705+dYXPmkp6LYuP2o4bqlCcH98RfhayUJ5NOPNs3GVBfW2TTR2KPIYcwAwX?=
 =?us-ascii?Q?yd9BcYSkq0sv3OmA9fyZFoqfZh6j8pP2TjyhrK7EQDSOFptYsNgXsQXQ4Zro?=
 =?us-ascii?Q?NFSdsnY+oz231SPzWFQa1JVm6GkpMp9Wv3O7jAGLnM240voEDOhQVmbq1fPT?=
 =?us-ascii?Q?fJRAne/R9HwFSumBc2ckjRQDDXQvMjsH/b+LZqMMSBAKvDoV49IPcca2ziyX?=
 =?us-ascii?Q?oWIiVTYUNi/SllhQL7kWVN9Oe4/ElnJX2MdBF23tOv3P5BMO+ZCJb887Imap?=
 =?us-ascii?Q?KP1sOHqdAKhY59Sm44pO1hh4DGHuafOnBRI6/pBwAl48Ns2ooYYubvUF2RrT?=
 =?us-ascii?Q?9qdIoHFoBxq+xc22Nf0Y1nhB3eImILCmZu6f1qizSHGI2c03T0zFD+/sBueD?=
 =?us-ascii?Q?FMlt2V9COFWpeqvvSmYiuGPNhRreAjCzSU8AHD3dm4wfSppSnyTvxPODpmpZ?=
 =?us-ascii?Q?s8H4VHIXUQYBHYDBzs4oPMmVvPXZQATUpN+vlxs7apJyjeMarZbDB3B7HDh6?=
 =?us-ascii?Q?eH9dUWvVEkmWCXBjgar4uURZP4K5PPwPrVZXmMFmI+t3e2PbaRlmcnIR4sim?=
 =?us-ascii?Q?Slb7EQEldcXTWbYdQPphDKvWuwkbtgGDJKIad5hfnen7TzETZeVhGnypAfq8?=
 =?us-ascii?Q?hzBXTl3Hoxn2X/RYQIdsDJjmTFnUYvYmoUw406iAAO1CY9CqQ/lez0Nw8xkK?=
 =?us-ascii?Q?TinRwTakqT1RZ1ClbFjY7YPqaNbVFfgBXDnuUScdxnb7vMpvjDdApI1BvBdU?=
 =?us-ascii?Q?PsOgSMH99xYo/NHRwprWYdGDZsK0ze/oWggxVJvp6XQUDz4HaAxbCVe/PVru?=
 =?us-ascii?Q?DoVaAuTjNxIidjCaLAh05gMqeUIQbQGEHTLgsenf0WNdThk8me+dJT9ZkOrZ?=
 =?us-ascii?Q?X3LNmucPYFALXR64qwMV8fFi7hNEDcYvdNHDUzUDptbIgVfrp7FNlJoKfyYA?=
 =?us-ascii?Q?iSSab7zy6RqOBlDjzC9nA61bzTyB2uO5Cz05GIYt/yHB41vIYs7zCbQ9ovJ0?=
 =?us-ascii?Q?mPGKK/ZsABT/AmjUtbTLngbvo4hIua2HYKZjn8Ih5JSxsva6CkSZ/cr2gJvh?=
 =?us-ascii?Q?PT1vbCfJKnkNewQFuIk0sOsgiWqGfk7iZ+9pmLaA1D2TSv70/2lDRrmLRDUy?=
 =?us-ascii?Q?+W2uq/e5yN/EXynMjX2+YFxeZ8OD1It0If0Juddh3RelET/Q4kvrKUNAtSzx?=
 =?us-ascii?Q?mlU/WXR3g6Ex+2EQemPulz9wW9wggBOPWHsleYe3daTx/uBQ27oa2LroxPht?=
 =?us-ascii?Q?EV2HgJGfTWTaAUJ+57VJudQgmGMUoUfqF/GSrDlLkrGQgDwzC+JjpzkcftJ6?=
 =?us-ascii?Q?hARwev5JHqUrrR3+EaN/zWTs4hf9/vGQ5T88ObnK0RrzfQpB567e8cjLUx/8?=
 =?us-ascii?Q?wtQpA8UJtKhuXtqzQD/r8BZlR+m3ooFTR8Yh3baNjbOzuPwwWsBZUbkKjbXZ?=
 =?us-ascii?Q?k1HwPkSRkobFEHOVt8oIiAshfbw5WRuWNtFG7HxoRDBvq42A94zqoi3RDy5z?=
 =?us-ascii?Q?ywR35dBVnceV0vSHzSMtP4HoV58dT01lUKSR93LiM2mR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91797011-c231-4381-aaa1-08dbf822adf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 19:20:03.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZjo818QCOMVue76CLQnEG99w/zq7VZP/8RS6BWG/gX/OdX8ZHo7gLpU98cXUwMkwTzvucKpKdQwfmRXpdOl7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-Outbound-SMTP-Client: 72.163.7.164, rcdn-opgw-3.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
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

On Friday, December 8, 2023 10:04 AM, Martin K. Petersen <martin.petersen@o=
racle.com> wrote:
>
>
> Hi Karan!
>
> >> This series doesn't apply to 6.8/scsi-queue.
> >
> > Okay. Thanks Martin.
> > Please advise how I can proceed with getting the patch set accepted.
>
> I tried v5 and it fails the same way as v4. First failure is patch #9, se=
veral additional conflicts after that.
>
> You need to submit a patch series that has been rebased on top of my 6.8/=
scsi-queue branch. I don't know what you used as baseline for the series in=
 your git tree but it is not a suitable ancestor of my tree.
>
> Your changelog modification is fine. Thanks!
>
> --
> Martin K. Petersen    Oracle Linux Engineering
>

Thanks for this crucial piece of information, Martin.

I'll rebase the changes on top of the mentioned branch and re-submit the pa=
tch set.

Regards,
Karan
