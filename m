Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACA774F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHHXhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHHXha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:37:30 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF8ADC;
        Tue,  8 Aug 2023 16:37:29 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378KrPVI011569;
        Tue, 8 Aug 2023 16:37:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=e1oAW6FfEOkuz033Da4R2MC3EC4DgjQEBwg/ASE8eKc=;
 b=aVaDB88PBO+lwt2dQaKEIN2eA3wDsn8sB+FSPyGKqKsYId69qzkCirIcJy0nCFCdFBR2
 GCNubI8gee6mXN3vsONWZ/dQKR6qYnv4FuHeR//kjdtFBaKQynaUYlTiCL/x2FLmGuG7
 GYs65TsBsUp3LfM3R12FLJDZXoVJmnwfSMNeyv31viKdrnOEhatR+JCfTHv2sZd+0WKP
 gAkpWGwyKubjVmAE9yiYLNQPiMRErDODnV8wgUuyKeETDAMvX4/H+2mkm4JPU9NwTuQd
 4298I5Rx91ngbN/XZ9Uv/5YneIidoBhw6JK6iIVbKJh5KULyZTFXp2N9YXyK60AjdsFo Vg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3s9n2f7gpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 16:37:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1691537833; bh=e1oAW6FfEOkuz033Da4R2MC3EC4DgjQEBwg/ASE8eKc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EpNKCOHBnn19HtswAFUeX80b4ZiDpyzoYp7biJDXAsIQahyanYqGuUDevoV4jKqyj
         iGPAzOV3Li6X9iYTK72V68yL8RpI5xDWoWXWPGMCfBdwDyYkrXywieT3/wdiheyDT4
         yLXxR/d624g/hvaejKKY4nDDESCamZiPjZWZeTV5TvnN/IajcxLVt2ALXEwdxaWZt+
         zboS2AN87nMVbfccKH7a87Qt20dXO9FO6wxVx0w81+3GZFvD+5YP7vJtgAXNF6SObZ
         CkG2HUPu8gyqZqCCoXY0pr6P6o1QTUvWbFXjIHXKt0yISK+Vfiop+VU2ZvYRu5NafH
         zOYg2G3SonHjQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 53E3D401DA;
        Tue,  8 Aug 2023 23:37:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 73A7BA0080;
        Tue,  8 Aug 2023 23:37:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=JVUKIZxz;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E8C26404B0;
        Tue,  8 Aug 2023 23:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gso8LpQkwPxk/u3xJzQmtMCczoNPfhimoSoPFrrSAuOaMGXXpNL5nNp2Vhmkjvk0zhP1k9txhtuLwNAt1FWons/YmA/ahbQ48rn7OrirklMXvVAL/SuObZ0+1bvbA6F/WOzu85oZ7pn5qFQ8G6twViNTWNjh32uVpLPNfvflY1ghWaRIzb0r0UUHoSk/ba0d7tQqR9oE/snSTgTiRQdWcPnY5eOYTaV+XIvEvJWUBbdvuSpnF2TyUVc4y4aAXLIEj4eH0OxyayjE0uZKmsQISwEorOArcXpSpWjPY3Avdhs3oW8RBBe3D7YpLOkFKOVd6tPZ+ACdJ9eQU8F/LUUyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1oAW6FfEOkuz033Da4R2MC3EC4DgjQEBwg/ASE8eKc=;
 b=JTe/Sb4vjPhnE0vHrBnehqo3tFrCaYfaTdU1Z+rSnN9xuQsRiRAtMF90FeLvbf2at65SWg0poTMdfu503pX6brMr09sr0Uy2E6rjizkkRLce5uPz/2TeYYk7OLPe1AjUGMPH2fEEW52oiu/M3PkzaBKeggO6eOvoFGB2pB8WQUqeDh5vm9kvlSb5rm9R3bcUdVexjyLZP0ALP6EUo862zxU4g4Ftg3PHECsOOBTyzQ1loxdmqBTgm1gpyCQjDZ38WpI0yabTQIL5iJZJkVNBaX1msFs5+ViAYsD2kiONzJg5YuUwXVOmqWnauvl+7QB0g3DoMPTzXEGet8koTHZtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1oAW6FfEOkuz033Da4R2MC3EC4DgjQEBwg/ASE8eKc=;
 b=JVUKIZxzHN2PPpynr2VZ3pRCMl9LHJtq+wyXH7K2gG6/XCnBiS4L3f8E3HW6v3ITrAK9In0BotCn90spbNheOC2h7WWKARajrQUjadHZwq1MNekk3wXVQzJcn/Hg6WDzvuqa48tIn/BRGuxY5steNls8+FhepbQl9z92EjLMXwE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Tue, 8 Aug
 2023 23:37:01 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9bdb:ffe:c29f:432f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9bdb:ffe:c29f:432f%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 23:37:00 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer
 driver
Thread-Topic: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue
 layer driver
Thread-Index: AQHZxFow++w3UXyhskGxvNTqsfGMb6/WNIgAgAB47gCAAQXsgIAAcwYAgAEQrgCABV1QAIAA+H4AgAAyw4CAAVoJgA==
Date:   Tue, 8 Aug 2023 23:37:00 +0000
Message-ID: <20230808233647.vkavlknkgieh4ukm@synopsys.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
 <ff9ca6f15936450696bff502c0047708@realtek.com>
 <20230803000417.qfuwsx5we5a7lfvd@synopsys.com>
 <7d47cbfdbc31436b89d3d92bf980c8fa@realtek.com>
 <20230803231156.laggnj5bzuhugwfd@synopsys.com>
 <ae619edfcce545b78697c6bcdadfff27@realtek.com>
 <20230807235636.mlos5tpeg5foymnz@synopsys.com>
 <f38e2a4cb00d40429bf3504a183bbc83@realtek.com>
In-Reply-To: <f38e2a4cb00d40429bf3504a183bbc83@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB5608:EE_
x-ms-office365-filtering-correlation-id: 41fede27-7aa1-4cbb-3cb1-08db98685cee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /S0hi3WlHA5lcfy/QCnnUOPdogTMMfhzCzXQnblK8lveQTCfY1rkwSwv5sIiivtHL7NiPhiFxroFss1KWAJfLdZm8q6avub6jV2XORz795CM58dNGxYwmjVZZE4L2mOzMihjbvfz130k/Gk3koFDW5jjHvPNArBCCynNUXjSzt45+BZ6Mal+ojxqhrfrYFv+Pn6bcC5q/ziOaZGY8E1GQHMWxj/UnUHwSVARQdscOuzJZeJ886DhfkjxPWeuKmLALWcyfZkxmzjT1KJAL7q60r0yI0mp3XaxA5IHQ145352AYV7+y00pPcT0h5nu8tW1ZGCh001qsKHygiDJo8PZuacibM9+5TP4frhJw90WBcBL7SlpVQvfLrGJG1HXOnnVlJmHQ20kImd4kSRaMdpzwWjaXR8bbaPkKjOt9MmWbG4a0ovSw1PS0qU+J24xj80DmzZDLdQFagz9dv3yt5XG6gcTrDn44c+7131MhDh+K+pGG1J5BMtk7hx+tSwemYNT47YBPSyrvtB7rDh8nw4k6WnnX/vxZe54Xto7c601my6kZFHDXph6ClpHP4BAeIyYmMjdODCe659Z4/rifNQ3jEuzgYvCj7QbXYHArZFh+OVv2DmBiu0JbrhHZd/myCnK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(186006)(1800799006)(2616005)(36756003)(4326008)(6512007)(316002)(122000001)(86362001)(6916009)(478600001)(6486002)(76116006)(54906003)(38100700002)(66946007)(71200400001)(66556008)(66446008)(66476007)(64756008)(6506007)(26005)(1076003)(38070700005)(8936002)(8676002)(41300700001)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk8yYTJVVktuVC9zeVlrZ0lzaThWMXBMVDVod0RMaTFsQmQ0MkRJK3hDZUk0?=
 =?utf-8?B?NlNIcFRldndhUmRvR1NqMXQ5d1V4QWU3T1pXUnBtOTRBNVczWlFTYnhWWklS?=
 =?utf-8?B?OGQ0RklOMlA2M0FQOU1VajY2RVNlb0xkSmJvem5jOGcwM1N5RmFlOTU3b013?=
 =?utf-8?B?K085TldZTjJtQXd5MmlGZmU3VTUwNXJueVlOamt5VVU3VWlGUVhwRElWOXcr?=
 =?utf-8?B?ZWdkcm5yZG5VSG9IVDQ0dUliajVuNW5pQ2VQeHd6dEo1NWR2OWdGRHJXeUEx?=
 =?utf-8?B?Ukw2SWswYy9ydi9VTUg5eWNHVm9UUHR3YTZzaVdsOWlkUUh4Rkp4enlmT3Iv?=
 =?utf-8?B?S0JGbnk3bVZONldmQjNVSDlLNFF0MVFoWlVoaGpzSk5UYno4dml3Tyt4bVhl?=
 =?utf-8?B?YTBLb0JndTI4U3NTRVpLMkpVazBnNmhqbWYyY0hwY1V2RUxoSXpYNEVBaUpF?=
 =?utf-8?B?MTRvUHlNN3p3MFZpMEdjZEEzSHFvMjZJYk5OQllGNmYxa25sd1NLRjdpeHRL?=
 =?utf-8?B?VlJjdEJZMWIyMkNwWWtKVzd1WVdTSEh6MmoxMXFwRURjQ2RQUXl0aU1TNlYv?=
 =?utf-8?B?ejErV2l3eHVFUGZVMFJ3ZjlBM1psM25MazVhY2VWMXo0emg0SWVqeHpvbWlV?=
 =?utf-8?B?VVZORnZZMysrcUJXeDNqNWpyUGlRcDhzTFR1bkJOQkRtWTdiSUc4Mm1DM0pZ?=
 =?utf-8?B?L2NpUWE3bWpZbTZaako5UDBPUGpqbVlob1Z2UzJDTmUvd2pGeWdDdDdFb0t0?=
 =?utf-8?B?MExIVHpvZ21seGdzOFpWeFA3QjlqK2FJdXliK05uT3BpdGVCZzlycFkwT1RP?=
 =?utf-8?B?cDBLb1R0RlRhYmQ4RG93SGVaMGNlclVVQ252THp5N2E3RTRmYm8yNG54YlZm?=
 =?utf-8?B?WFY5eDBqSnZGeHNSQVBrdDJYY2JqUzVxeEE4Y2V3YXNHdFlFb3hvQUNTZWFJ?=
 =?utf-8?B?MTVpbXM1NnlscWJhT3FGTGlnWjh6NlBuSUFoYno5NjR4Mnh4UXZ6Vk1pUW80?=
 =?utf-8?B?aHBMMndBSUp5QUw2aUM5dGppL2k2NklqdTFTbS9KUFlUOUZxWTYrbVZ3ejY0?=
 =?utf-8?B?eG9vNmdsSnFUZ3ROVVhEOGFVSUNwY2hUNmZMVVMydGhGdFRMRGczbTQ5bEpX?=
 =?utf-8?B?WkN4T1dSUUszMzVoSmNDYWRDb3hsM1FRNm5nZ3lJZCtVNG92NHFmM3M2azZB?=
 =?utf-8?B?UDdJZ0pOSmYrOXMxSk5MTTBJa2ZYbDd3NFREYktzczRyZnVLa1ppTGRqOGlp?=
 =?utf-8?B?NmRIdktuL2R3WnhjNGhiSllpblMvRkV0ay8vOXpLeVZOUHVVSzQya3pJR2ZO?=
 =?utf-8?B?dHhjZVdPZXBNVVg5NnFMQ29BVW5KT09CMEVMUFhkM2dzOHFLR0s4bkNwVnI0?=
 =?utf-8?B?TGJINnN6L2djMW0yV0grYjAyMG1BcUtJMmpuV3diYWQ3Zk9wR0krVzQ1TlU5?=
 =?utf-8?B?M25MWk5ic2hRYkNKd203TmtvUGVJRDRZbGcrN1JHRCtEQVJiVGdBK1ZPR1Rh?=
 =?utf-8?B?T1lMQ2N3WG83RDA3eWUyRGZ5Nmx1Z3hvaW8yV1ZpUSthMFBEK2s3d2dwNHp6?=
 =?utf-8?B?U09QWEhnc2VicnZxUlFDcEVvZzN3dlE4Si8xVWg1THZtYStXeUlYYk5Fb3Fh?=
 =?utf-8?B?d2NsQnUwZ3FzVUc1dlhBVVFRdUIzZjBKNEFJVkJ0enRZQUhVZ1YzNlV6RkFP?=
 =?utf-8?B?S0JESGx0elQwVWdYUW12a2p6MVBLOVhSSjdvSzdSaTlkN0JqT2c5ckxaTSt6?=
 =?utf-8?B?MGFhZEROZE4wTlBsc1V6N25vbW5jcUd1cjJPODVQMFZrV1NrTFdiVnZ5N2ZP?=
 =?utf-8?B?ZCtQQ1pWMjVVUWMrSVRpZ25iaXYwN090U0N4SjM0U0RiYzJsd1ZYSFZLMjAz?=
 =?utf-8?B?MlBRamEwZnNXQmg2RWNocXdKOGhob0g3UG1VZmJDNGJEdXpGSWdmOTE2M3R2?=
 =?utf-8?B?STJGaDYwcmlML1gwYTVqQ25HdDVibGNvbVd6M0gwa3FEY21oTE9USzFtT1kw?=
 =?utf-8?B?SWRGSm9nZk5zVWMrTW9kYTNHd2Y3SlRJczNvNS9od0FQRVVNMnZCZTdQdXlL?=
 =?utf-8?B?cmtWZFE5ZVNmWTNKMG1BRVpvVzBwSjUwYVowTnIwbzJhRXB6eEt6TTdEVGpF?=
 =?utf-8?Q?z8I4+vYmvtHzAKZ8U7MVrE1Uk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE61172FD2B31B4C995195B5E6AC28E6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZmkxSTZPSVhWblBHdFhlWEJJOXgyVURmcXVoWlptL0Q2NE9ZclBBMXVubWMr?=
 =?utf-8?B?L2FkbFpjLzh2Mm1JVWNuRHorOVd6WHo4eFIzL3V5dFFDb21pOFZBdGNjSXlr?=
 =?utf-8?B?Y2hnZDczN01rOGZHTFhGL016UlJibkIrbmNhMmIwbjMyMHo3b2pzbVhSeHVk?=
 =?utf-8?B?a0ZuRXgvZTNtR2xXbTRNYlkvUDAzbmFoV3ZpQmhBQmJERGZHQ2NwZFl4Ymtj?=
 =?utf-8?B?aG9Zak5ocDlzTjlCQkd1Si9DU3F2MnI2VGg5dGx2eVFDMm1pQjhKU3dhakNo?=
 =?utf-8?B?NVlrVVgwcG1jZjZRNEN6ajRCWjFUSXRWMzMvcmlPdnlpeTlCV2tXUk1NUjRX?=
 =?utf-8?B?UVRXczBFSjFHZmJ6L2RTUWxkcUlaaFhoSXRBdzlHRm45VDNWelBTUWFQeXJy?=
 =?utf-8?B?Z1ZKMjVLTEJ6VC9kNzBTa0crSlZWVHBCUGFMek5zbEwzZDBYTEsvNFB2VDNo?=
 =?utf-8?B?MHNDTFJianM0Ymc1alJxa1BOOWRWcC9ERzNuTkJvcUJqTnh3TTRKZVdpVllD?=
 =?utf-8?B?M2F0RjErd090TmJ5eENvTVpDWUJvcC9TblZyY1orRzVpMGtQR09CcnVreHZR?=
 =?utf-8?B?UDk1OEl1MEhEM25YT0xnUDNmMER2V3dFUUZ3b0U2Q2oyZk1YdGM1OFlLdEhU?=
 =?utf-8?B?cEcxSUFDdU5jdCtwNFFTK25Wc28wZG5ZOC9NcmhZbWVwUGRRZnRRMGsxMlI3?=
 =?utf-8?B?Z21KcDdQOC81QzZYTjZzQ29nNFAxT2dSRnczQnZUM2pQeUx0MXNWTVpXZXcx?=
 =?utf-8?B?ME5KanFBK3FNSGZPbkwrZ1VsOGMxakRqY2gycW9Va2craHBVbHpTbFQ2N1FK?=
 =?utf-8?B?cHowbFJCTTlNVkNudXpNejNPTk1IQm9lYm5CUXdlS0IwSTFvelZCa1hEU2Qv?=
 =?utf-8?B?ZkJWMFRFV3lCSTUrWWplM0UxYkMyOFRPT1k4OTM0TlovZGVVam1PcHdvajVy?=
 =?utf-8?B?aGE5WVdSeERxUWoxaUh2ZnZKNnVCMkwwZWZhdHIvclM1NDMzMmhvd3c3ckZK?=
 =?utf-8?B?UWtpemk3VXlzeWkrQWo5NmlXTVI2Lzh5ejliSEYreG01WnR2UjNPd2FpT2lE?=
 =?utf-8?B?elEzZ0FxQ1d4ZzNobXRrVnpmMXNjUkVwRFA0OGpzOWJZa0F2c0dmbHhSNlpR?=
 =?utf-8?B?eDViaER2MEVPZUdVUFZ2RnI3UkRMc2RSRGZ1UnlvaFYwcU1wS1BybWV2NDlY?=
 =?utf-8?B?R0FFVG9HRXg3TUQzQkh1RkhQclpGNGJxeGY3NXQrcVZJZHlZQ2dEek03VDhR?=
 =?utf-8?Q?DC1758cDHpgdPqz?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fede27-7aa1-4cbb-3cb1-08db98685cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 23:37:00.5877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aM3lgapg261vOVtMzVa0CeXIr2iH2eg0sUHj7iP3sM4z9f1auFJohDUyvVyYoSKVAFWbr6ziFgtdpcoVQMGIoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
X-Proofpoint-ORIG-GUID: OzhmHwrK5ESMKu7gwYKEsDw5o_Pl_sKg
X-Proofpoint-GUID: OzhmHwrK5ESMKu7gwYKEsDw5o_Pl_sKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_21,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=987 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308080210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMDgsIDIwMjMsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4g
SGkgVGhpbmgsDQo+IA0KPiA+IE9uIE1vbiwgQXVnIDA3LCAyMDIzLCBTdGFubGV5IENoYW5nW+aY
jOiCsuW+t10gd3JvdGU6DQo+ID4gPiBIaSBUaGluaCwNCj4gPiA+DQo+ID4gPiA+ID4gPiA+ID4g
PiArc3RhdGljIGludCBkd2MzX3J0a19zZXR1cF9yb2xlX3N3aXRjaChzdHJ1Y3QgZHdjM19ydGsN
Cj4gPiA+ID4gPiA+ID4gPiA+ICsqcnRrKQ0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4gQW55IHJlYXNvbiB3aHkgd2UncmUgZG9pbmcgdGhlIHJvbGUgc3dpdGNoIGhlcmUgYW5kIG5v
dA0KPiA+ID4gPiA+ID4gPiA+IHdoYXQncyBpbXBsZW1lbnRlZCBmcm9tIHRoZSBjb3JlPw0KPiA+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEJlY2F1c2Ugd2UgaGF2ZSB0byBzZXQgdGhlIHVz
YiAyLjAgcGh5IG1vZGUgdGhyb3VnaA0KPiA+ID4gPiA+ID4gPiBzd2l0Y2hfdXNiMl9kcl9tb2Rl
DQo+ID4gPiA+ID4gPiBpbiB0aGUgZnVuY3Rpb24gZHdjM19ydGtfc2V0X2RyX21vZGUuDQo+ID4g
PiA+ID4gPiA+IEluIGZhY3QsIHN3aXRjaF9kd2MzX2RyX21vZGUgd2lsbCB1c2UgdGhlIHJvbGUg
c3dpdGNoaW5nDQo+ID4gPiA+ID4gPiA+IGltcGxlbWVudGVkIGJ5DQo+ID4gPiA+ID4gPiBjb3Jl
Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkgZG9uJ3QgdGhpbmsg
dGhpcyBpcyBhIGdvb2Qgd2F5IHRvIGdvIGFib3V0IGl0LiBEbyB5b3UgKHRoZQ0KPiA+ID4gPiA+
ID4gZ2x1ZQ0KPiA+ID4gPiA+ID4gZHJpdmVyKSBjcmVhdGUgYSByb2xlIHN3aXRjaCBzdHJ1Y3R1
cmUgYW5kIHJlZ2lzdGVyIHRvIHRoZSBzYW1lDQo+ID4gPiA+ID4gPiByb2xlIHN3aXRjaCBkZXZp
Y2UgdGhhdCB0aGUgZHdjMyBjb3JlIHdvdWxkIHJlZ2lzdGVyIGxhdGVyPyBJDQo+ID4gPiA+ID4g
PiBkaWQgbm90IGV4cGVjdCB0aGF0IHRvIHdvcmsgYXQgYWxsLg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiBJbiBvdXIgYXBwbGljYXRpb24sIHRoaXMgcm9sZSBzd2l0Y2ggaW4gdGhlIGdsdWUgZHJp
dmVyIHdvcmtzIGZpbmUuDQo+ID4gPiA+DQo+ID4gPiA+IElzIHRoZSBvcmRlciBvZiBvcGVyYXRp
b24gYmV0d2VlbiB0aGUgc3dpdGNoIGZyb20gdGhlIGNvcmUgdnMgdGhlDQo+ID4gPiA+IGdsdWUg
ZGV0ZXJtaW5hdGU/IEFsc28sIHdoaWNoIG9wZXJhdGlvbiBzaG91bGQgaGFwcGVuIGZpcnN0PyBJ
dCdzDQo+ID4gPiA+IG5vdCBjbGVhciBob3cgeW91IGhhbmRsZSBpdCBoZXJlLg0KPiA+ID4NCj4g
PiA+IFdlIGhhdmUgYSB0eXBlIGMgZHJpdmVyIHRoYXQgZmlyc3QgY2FsbHMgcm9sZSBzd2l0Y2gg
aW4gZ2x1ZS4NCj4gPiA+IFRoZSByb2xlIHN3aXRjaGluZyBmdW5jdGlvbiBpbiBnbHVlIHdpbGwg
Y2FsbCB0aGUgcm9sZSBzd2l0Y2hpbmcgZnVuY3Rpb24gaW4NCj4gPiBjb3JlLg0KPiA+IA0KPiA+
IEhvdyBkbyB3ZSBrbm93IHRoYXQ/IFlvdSdyZSByZWdpc3RlcmluZyB0byB0aGUgc2FtZSBzd2l0
Y2ggZGV2aWNlLCB3b3VsZG4ndA0KPiA+IHRoZSBzd2l0Y2ggZXZlbnQgbm90aWZ5IHRoZSBzd2l0
Y2ggd29yayBpbiBib3RoIHRoZSBnbHVlIGFuZCB0aGUgY29yZT8gUGVyaGFwcw0KPiA+IEknbSBt
aXNzaW5nIHNvbWV0aGluZyBoZXJlLCBidXQgaXMgdGhlcmUgc29tZSBtZWNoYW5pc20gdGhhdCB3
YWl0cyBmb3IgdGhlDQo+ID4gc3dpdGNoIHdvcmsgZnJvbSB0aGUgZ2x1ZSB0byBjb21wbGV0ZSBi
ZWZvcmUgdGhlIGNvcmUuDQo+IA0KPiBGaXJzdCwgdGhlIHN3aXRjaGVzIGluIGdsdWUgYW5kIGNv
cmUgYXJlIGRpZmZlcmVudCBkZXZpY2VzLg0KPiBJbiB0aGUgdHlwZS1jIGRyaXZlciwgd2Ugb25s
eSBub3RpZnkgdGhlIHN3aXRjaCBpbiB0aGUgZ2x1ZS4NCj4gVGhlbiwgdGhlIHN3aXRjaCBpbiB0
aGUgZ2x1ZSBjYWxscyB0aGUgc3dpdGNoIGluIHRoZSBjb3JlIHRvIGNoYW5nZSByb2xlcy4NCj4g
VGhpcyBpcyBhIHNlcXVlbnRpYWwgcHJvY2Vzcy4gU28gdGhlcmUgaXMgbm8gb3JkZXIgcHJvYmxl
bS4NCj4gDQoNCkkgc2VlLiBUaGF0IG1ha2VzIHNlbnNlIG5vdy4gSSB0aG91Z2h0IHlvdSB3ZXJl
IHRyeWluZyB0byByZWdpc3RlciB0bw0KdGhlIHNhbWUgc3dpdGNoIGRldmljZS4gSSBuZWVkIHRv
IGxvb2sgaW50byB5b3VyIGltcGxlbWVudGF0aW9uIGluIG1vcmUNCmRldGFpbC4NCg0KVGhhbmtz
LA0KVGhpbmg=
