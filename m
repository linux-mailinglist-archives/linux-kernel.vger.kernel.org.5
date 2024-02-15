Return-Path: <linux-kernel+bounces-67846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A528571C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C481F23D05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD33145FF1;
	Thu, 15 Feb 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WCnXAeCU";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kL8eGGwd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Doc4OKDt"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E2145B26;
	Thu, 15 Feb 2024 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040630; cv=fail; b=Qj15eTsHjjrGVsC0eHfrg67g5CiXa//YQ1OTVYTIoJ1aPeDzQrwyffrizoQ3bJAbekFspZmFxIaIW0wSWBc+PE++/kEES/mxKjLalHfgs5d/7Qg4JvV/r3+IiBkeb5OTz0A7FeCVKCnHmXSTmlCXNh2A6fuZRr95dbAAqFz90WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040630; c=relaxed/simple;
	bh=3ZCHif7HVb+tZRLCS92g3Nbsd/6M0NLnqZ1mrE78O2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYVDEwMr0saT3pmVXHR7x/eMfjqqK/xl+n2m11bJuc8iLE3Z0noZ/68UGIQ0YzLxgaeAEjpIA+vCdjHRxEYUTa10/JyiuqkrOZUF9eV7YlE27/HcBI0L/uwjatiiV9dzNsEjFbLEyTK4fJQcL8QEckOkGFUwm7+1E0CCE/S08xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WCnXAeCU; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kL8eGGwd; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Doc4OKDt reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FNXiEb013232;
	Thu, 15 Feb 2024 15:43:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=3ZCHif7HVb+tZRLCS92g3Nbsd/6M0NLnqZ1mrE78O2U=; b=
	WCnXAeCU2bB5s5JL+UxvdSvimEi7asjDj5LbULZuTfXNve9vru17gihoQhMr3d0p
	CUlI20xikWGw7N0E2lOp0Wuv2RiuckScl008WUmfkWwu+Bj8KExcjZ4gfmJEPbIn
	TCiMInJd/iiRWRZrTIFm2FxFKDFERKL5gPAXEN79HgObpVTSfRZLQbXZQrt3tQ2X
	MSiviGnyDl1nbZge3alpuG6kmIh5R8LIspXqHUC60OgSXVa/80Xfrp8Ztez2wsO8
	GdO3Ch1y7pJ+C17g1w+ElskMla6kvaC3uji7HZAN2nsOvn00RUOFynoEaF70yyOr
	kF6auHDZVvDh2owv0MBsKA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w68xwe3n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708040609; bh=3ZCHif7HVb+tZRLCS92g3Nbsd/6M0NLnqZ1mrE78O2U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kL8eGGwdD3saI08rXlpE0+4Ynw+RlmJQKqqzocLYlS0+4wdXsOftZR0uWXWDh6ZlU
	 beF/Te0mq64E3T/AJugqlHzcmsky0w2V38PsojH0TbQdg/k1J+DW76niRwb/Ed18pz
	 jxPyzKVUprk9AXbgY5+8rSdlIL1AmsvVjYKzMoaaXOp2Q+KoJIBweXDMdqN3luHlG/
	 FSPResIlNPmMDMyKqX1lNdbGAN7e4u2LiKNUC2LfLOxeyOTde2MYjC8dnjp0sx294W
	 6o/GRqXyov1dlrBw/Y3VbO/HOuNyMu5wFPKblo5gz/gyoMkVne+249Y/t49Sm1q6U1
	 tbVdt+pUc3FhQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B2EA04048E;
	Thu, 15 Feb 2024 23:43:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 27D97A005C;
	Thu, 15 Feb 2024 23:43:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Doc4OKDt;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3B3814048F;
	Thu, 15 Feb 2024 23:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8/4Iq2/226Kf9SawdpomoUgQeaJ/T4/Fv5uv/E9OyBePj58nM3MWo0W/yll1bDBILf+BiqpRouijl5nsOdrRG17Jk+w2v2rHllqF0m8xUFsbn/vqs9seN4UmH6AzXFOFnS+XleRD4dOSQfQMGrPm5E7SWpvDHtJx6eHidLHCZHqtBC7kcdNoIYOZ3pvN+KFtVUsHNFEBw8W1yqSYLeWM2lSfpV7zotcjqX0OAx2kfpvzLL41IgZzyTEAArCZYThKi8To29fV2M8ydBmL/3OmmLJ4LGcaonG0tr91KY/WbtjShgd+ZbksMnmCTDe5/P6d0KOHhPYe3xFJbWwtRFMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZCHif7HVb+tZRLCS92g3Nbsd/6M0NLnqZ1mrE78O2U=;
 b=l2HxjUXtPhrXEoFhCJRunuiXcEq0kxAJ2Ak3Rf28EYqstPpGC2Xwh1Rgsj/7s6KOMvftcsR9hIBJl14ZkCZDTqFHY6VJsblKrFp9HJa6nL1+RUqB9NxI3YXkqYiFlam+S7vYDRL83u6HLSA2WCDEvOFQmEjoxvoUC8pNNDaKdm+f+RUYf/f6zuhCC5pauxXHfjzOAtlYC6xfxQqrzuG+GrZ7eHf+4KbgdUNizOGoqBReMWB3EtWtVW7NWgjVnkEdgFMYkfzmMeRxH1ub0QlG1/HvIGBAGHBFA33hRLZ+05okU6yl5XC7grqPOn3pTiZgpL3APrtwFfsLFkT9oiIejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZCHif7HVb+tZRLCS92g3Nbsd/6M0NLnqZ1mrE78O2U=;
 b=Doc4OKDt33KJ8zHeHlGh5PFcn4zAMFc1z/Q51uzDGFg/bII2Gigcz+DddkYR/8k24/iNff/Xs1vRy60jJ1ebS4n2Ua2zpm+EPKDEjHyNBGdWp2/CH/EW12IHnvN7NsvTNU7VdkASw2J+FC6xFvwqiq65oOYaJAl8xVklKQiTngw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 23:43:23 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 23:43:23 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v14 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v14 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHaWLwAq9n9dZO5RkmsM1wpNgusvrEBH1IAgAAmogCACtoUAA==
Date: Thu, 15 Feb 2024 23:43:23 +0000
Message-ID: <20240215234318.gsyjcnwnjumafg5r@synopsys.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-3-quic_kriskura@quicinc.com>
 <20240208234154.6jq2oah6ondn3jlq@synopsys.com>
 <af73110d-e13e-4183-af11-aed869ac0a31@quicinc.com>
In-Reply-To: <af73110d-e13e-4183-af11-aed869ac0a31@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7489:EE_
x-ms-office365-filtering-correlation-id: a9829d37-457f-4840-9133-08dc2e7fe5fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gnQPt68t8uv2RY/6k7n4Nc0BHV8SMZb8rq+KPXDwWpyJ0oJYE2ZpgYeEHmE6Zv2vUQl4AMje28J+n/s84MBG0dOmlMe6MhSXAjqlL860iPQKHDazi41ovls31d9MWBSbIrM9avK9Z2lxV294dvq/XHHjKK/lw8a4CmwKh6A0zQzPPs2pN7MA+zjIyQaDq/rLZxKaAu89fvQxX/L3cn+t8ZWlliwHLZ2XeJD4b/Tgex9hR5jWCsw6JIzU7b30h2D/TYaK25s/9YqdQ5a8hsYgyrH7iMz2n77oUhpLrhYy0tkrfU60HVWqTHPXtSWmPA8Sn2vQY6M4m8Zypsbwf6t07FfEIBPlprhemYUWjCepR8YEaXKV6Oeut6jH+OLyTCl5CK+EOaapbnHYRcEd8qMDvcHYRonUSdhVfVeSnYsUvs1UyPOJ3VfD3wx8JmLL3vJIQFURcPW74WjNLD0RLPjxY7KfdpKYPFkmjkeFPyTytMu7at95X16ZQGAviKcjrImQekDMIs7wvap89MMUc67Da26EKfo85CQczlsFJn8yvQ0+ZuUC8h9RwxjszfCW9xr7b5T6z29bu0k/SOMYOnUWTa0RDcPfEYIm6XEGKNYX7k3cKcbJ7SmUqhxAWiYO8ZGm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6916009)(316002)(54906003)(41300700001)(83380400001)(2906002)(4326008)(7416002)(8936002)(8676002)(478600001)(64756008)(5660300002)(76116006)(86362001)(53546011)(66946007)(6512007)(38100700002)(38070700009)(66556008)(66476007)(26005)(6506007)(6486002)(36756003)(1076003)(2616005)(66446008)(71200400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b3lvVXUyZGFLV05YOTZRbkhtekxnWjJ5NkpNam9SZ2JnZVpHQW9nZllzQlF2?=
 =?utf-8?B?MC9naytadWl2eW0xc0JnaHorV2xydEVIQmhZd0FUT1dla2NwVUZOS213MnFQ?=
 =?utf-8?B?TVdtVFhqREV2c1lZUjVWbG90M0ltYlZSRnlVUWRQa01qVjdWb2xYZHhWbzZI?=
 =?utf-8?B?LzBPeXdsaXpvcE51dTlsMHlEZkVYV29DOFI3SzZVTEZLMXByTno3YzJmcHVq?=
 =?utf-8?B?TnZvVmp1SnYrMjhDbXpzcFg0dUViMHR2cENTZzNleE1ZMHR6anhYNUJQUXJa?=
 =?utf-8?B?alhpR1Q3azJDNDlpZFpHWTBTbWsyU1pKaWk5NHFERFZHQlRMT0Nmdm5GM2Vx?=
 =?utf-8?B?aTUvT1ZXbEFHdHE2bzVNVU1mNThHYmQ4UW8yZEo4YXBZRTRiN0RsRTFERFV1?=
 =?utf-8?B?VnVaZVlZamovMnU3OGgwcThGWkF5anAzSXNCZHVmb3M1aGxURzU2Ukx1bnJy?=
 =?utf-8?B?cU52MkJ4SmYwWGVBUTQzQkZNS2ZEMU05UHJHejd5RG5NbkRwNUFhUWluRkE3?=
 =?utf-8?B?OTBQWk80VmZGS0hrUzU1M1ZMRHpGaGswMnNxZSs4TXRpMTkrL1NLTEhjY2hB?=
 =?utf-8?B?VlV6S2UyR0w5WERha0FBWS9KbHd5amQ3aGxkQWxzQ0g4N05laUxwTUhPTktv?=
 =?utf-8?B?MnNxQnArUGlSRmwzVGJpaVM0SngzTnM1eGNXaGM3Z3JIREEzaDdiRllxZW12?=
 =?utf-8?B?YTJRNTFIaFNjeGhEMzc2RVVGRWE2KzZ2QUs2cGVBUU9TY3RMeEZFOXNlNDNZ?=
 =?utf-8?B?Zlk2cTdkMVR3NFZoSnRkTXNnb0RSRnlSaTZhYXViRWJWb01NOVVSeUprb0FU?=
 =?utf-8?B?MGZvaFZOdndpc0IyakdrMVFydmVUWjJzZjhhMTBMVHcyTCt0TjVSZVNtRmxU?=
 =?utf-8?B?blM1YWg4RHdXMFcxL29nazlKVHZ2eWRQMXNWQzBCZ2pHaC91aGJNR2ZPRnAx?=
 =?utf-8?B?Y3ExYnhMQ1BOU0NhQ0tTV0JVRUhEVmovNDg2NnZBZDU4V1gzQTAyRXdZR2hu?=
 =?utf-8?B?dkc5MmRJWE1nZWFNVXRUSmZjM2x3cWxILzNSM3JKV1FZeDRIZkk5WU92Tm1X?=
 =?utf-8?B?V0RwQlVDTS8yWmUwMU4rc3ovRzFQdkhmUEIvNnIrUWdKbTRLanV4b2pnZXhk?=
 =?utf-8?B?c1FMRmdJTkw1bUVLR0g3RVU2R2VZUEwydE5lVW9GN0lWdHhwZFlZTTJPQUUx?=
 =?utf-8?B?QmlOUkVvU29nODFmMGg5dDdZUFVrdlJVaVk1M1dpcHJuTU5tdHBJUGxZVFd0?=
 =?utf-8?B?NG1COFlSTlN4Rld2TUNEVGRCQjR2OXczbWV2MTRieWFoTzN5MUQyL0t2amo2?=
 =?utf-8?B?dFozelIxVnBQL0JNVGZabUppTUtRREx0dlUyWUV3aGw3Q3VXN1pqZjBGVHNQ?=
 =?utf-8?B?U3p3UE9hVTVtVUhvT0VlaTQvNlJsc2dLNmhFOGZneDY5RFl1YjN1Q3NVNUo4?=
 =?utf-8?B?cjE0VmdkSzhtNUg2L0JScWlXdEI3ZUZvKzdkM0wwR2p6WGl6N0VNdThOTk5l?=
 =?utf-8?B?Nm1lWDJkTWJqdGRieVpCQ2JjY3FvNW9uVVBncHY5anBWRldqUkRydnZxcUZr?=
 =?utf-8?B?YjRja3daWkJvQ0JSSWRmbGM2eDZuNVMrUjdxSkdoRllEMWVLQjBMWTkvTEV1?=
 =?utf-8?B?VjFHc05rS2VEbTZRcjdxemxUZkx2dFJnSmhOT3JyZThKeHNmSlEyZ1lwSHIx?=
 =?utf-8?B?QUxVSmdaNkt4TTIwT2k5a04yZkV2aXU2TU1zcllMTDNHU3YraHpOdFBmRDEr?=
 =?utf-8?B?VG0veWtBcjlvb3ZMUk5jVk01cUpBTVhpU3hRblkzTEJqelpWYkRSSzllQU1h?=
 =?utf-8?B?SEJ6YXlVZ3I4NVJWZ1JGbnQzaEdaVjMzUm9FT0g2dSt1T0F2Z08yNllYeWhl?=
 =?utf-8?B?VW9JeTg0dXZwV2RobG5DTER6Y09RUkdaRE9ZRlRnaGZ1dzJlSGdGMStKZUd5?=
 =?utf-8?B?Ui90UEZsOXJMNGR2a3REd05Ra0FJcnQ3bkxBRGFsUXBEalJoZ0h0S09aRG8x?=
 =?utf-8?B?WHp1TEZ3OGIwamlyeDVwSllSWnZCV1hVM3RHK1JaQTFzcFhBQkR4Nzl2YlB2?=
 =?utf-8?B?TUQyMm9Ja3hiOXdPVlFZZnYwS0RpRERCS1dNVGllZHR4TU1qUWZnZlU1RmJZ?=
 =?utf-8?Q?s4WKCeG4KQ+Jse+hL4bW53Prl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BE58D81C3A91A468DCCF5F6D3D94DF6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tabD8g70YIAqj0zWsyhAD17j+eW3QdhLRTaV5o9EbTU/DnQN9X0mUQf0cZBzqslEpwIP297Gzff4HZ3/qvzlm9zCSNXn2f2ufvWVZoOWWtxzeQykxZA7mkVVjlQewXwnF6w7E+G6XYwc5SsI/LaHLGuaCDpBA3BjVwtFZNG0bW/0oDFrTHP4JJZjvoViqaILEdlf6yWXBw0w2xfJntxOk4ZTk1eraOTNjI1AUNTzOG0YFsdcLNoXQIeFalKsiU4WsgkXNQUZK1S6cajVPLNKgXsEmmVzCyUiXUFR41di/Lu78C3f4yI4O2aSPrwOSKD+QzNenbY6MwSCE9lphAOXHQ+EnI8gaUyW7NZ/+azVK4wuGg1gDqMs0FyAEAP860b1VAlLeGkU8HPZr38hzYHN/s5cEkb1pH+VkQ7Dui9MlN37WKASzAh8HsUuf6CFDkagPi3NDTsKIAuT/SZb9ED8JDLp3ygRZkkbnSBWKskSbvBl88b5f4STh/Fi2n3cDUS/3KaVSE4Gengp5PHfN7/UC4xsweeB/G0FNM81HjHNIPuqZn4EbT1MGIvbUt9Nui/P1dqJKB3Xkse1+7CQdm48QzWPr42eA71ALlgjS1rrwlYpuyyRx0HvlojSeyJUMQ0vaOnj81oN5omicHAOBtNf9A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9829d37-457f-4840-9133-08dc2e7fe5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 23:43:23.3788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wN5MgxcwBsDmKZAD+y45KEXlUEuX8cXAF2zyu/F3i0xE3iex5bk9Yd80pZZLjoOYIKG+Qxm4dy0VZCHQgqKVFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
X-Proofpoint-ORIG-GUID: i6vDUR8dw1UZKZgueEUXTB2Ma_ve_3PV
X-Proofpoint-GUID: i6vDUR8dw1UZKZgueEUXTB2Ma_ve_3PV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402150185

T24gRnJpLCBGZWIgMDksIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMi85LzIwMjQgNToxMiBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgRmViIDA2LCAyMDI0LCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiA+ID4gQ3VycmVudGx5
IE11bHRpcG9ydCBEV0MzIGNvbnRyb2xsZXJzIGFyZSBob3N0LW9ubHkgY2FwYWJsZS4NCj4gPiA+
IFRlbXBvcmFyaWx5IG1hcCBYSENJIGFkZHJlc3Mgc3BhY2UgZm9yIGhvc3Qtb25seSBjb250cm9s
bGVycyBhbmQgcGFyc2UNCj4gPiA+IFhIQ0kgRXh0ZW5kZWQgQ2FwYWJpbGl0aWVzIHJlZ2lzdGVy
cyB0byByZWFkIG51bWJlciBvZiB1c2IyIHBvcnRzIGFuZA0KPiA+ID4gdXNiMyBwb3J0cyBwcmVz
ZW50IG9uIG11bHRpcG9ydCBjb250cm9sbGVyLiBFYWNoIFVTQiBQb3J0IGlzIGF0IGxlYXN0IEhT
DQo+ID4gPiBjYXBhYmxlLg0KPiA+ID4gDQo+ID4gPiBUaGUgcG9ydCBpbmZvIGZvciB1c2IyIGFu
ZCB1c2IzIHBoeSBhcmUgaWRlbnRpZmllZCBhcyBudW1fdXNiMl9wb3J0cw0KPiA+ID4gYW5kIG51
bV91c2IzX3BvcnRzLiBUaGUgaW50ZW50aW9uIGlzIGFzIGZvbGxvd3M6DQo+ID4gPiANCj4gPiA+
IFdoZXJldmVyIHdlIG5lZWQgdG8gcGVyZm9ybSBwaHkgb3BlcmF0aW9ucyBsaWtlOg0KPiA+ID4g
DQo+ID4gPiBMT09QX09WRVJfTlVNQkVSX09GX0FWQUlMQUJMRV9QT1JUUygpDQo+ID4gPiB7DQo+
ID4gPiAJcGh5X3NldF9tb2RlKGR3Yy0+dXNiMl9nZW5lcmljX3BoeVtpXSwgUEhZX01PREVfVVNC
X0hPU1QpOw0KPiA+ID4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjNfZ2VuZXJpY19waHlbaV0sIFBI
WV9NT0RFX1VTQl9IT1NUKTsNCj4gPiA+IH0NCj4gPiA+IA0KPiA+ID4gSWYgbnVtYmVyIG9mIHVz
YjIgcG9ydHMgaXMgMywgbG9vcCBjYW4gZ28gZnJvbSBpbmRleCAwLTIgZm9yDQo+ID4gPiB1c2Iy
X2dlbmVyaWNfcGh5LiBJZiBudW1iZXIgb2YgdXNiMy1wb3J0cyBpcyAyLCB3ZSBkb24ndCBrbm93
IGZvciBzdXJlLA0KPiA+ID4gaWYgdGhlIGZpcnN0IDIgcG9ydHMgYXJlIFNTIGNhcGFibGUgb3Ig
c29tZSBvdGhlciBwb3J0cyBsaWtlICgyIGFuZCAzKQ0KPiA+ID4gYXJlIFNTIGNhcGFibGUuIFNv
IGluc3RlYWQsIG51bV91c2IyX3BvcnRzIGlzIHVzZWQgdG8gbG9vcCBhcm91bmQgYWxsDQo+ID4g
PiBwaHkncyAoYm90aCBocyBhbmQgc3MpIGZvciBwZXJmb3JtaW5nIHBoeSBvcGVyYXRpb25zLiBJ
ZiBhbnkNCj4gPiA+IHVzYjNfZ2VuZXJpY19waHkgdHVybnMgb3V0IHRvIGJlIE5VTEwsIHBoeSBv
cGVyYXRpb24ganVzdCBiYWlscyBvdXQuDQo+ID4gPiBudW1fdXNiM19wb3J0cyBpcyB1c2VkIHRv
IG1vZGlmeSBHVVNCM1BJUEVDVEwgcmVnaXN0ZXJzIHdoaWxlIHNldHRpbmcgdXANCj4gPiA+IHBo
eSdzIGFzIHdlIG5lZWQgdG8ga25vdyBob3cgbWFueSBTUyBjYXBhYmxlIHBvcnRzIGFyZSB0aGVy
ZSBmb3IgdGhpcy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0
aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYyB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gPiAgIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDUgKysrKw0KPiA+ID4g
ICAyIGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gPiA+IGluZGV4IDNiNjhlOGU0NWI4Yi4uOTY1ZWFhZDE5NWZiIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+ID4gPiBAQCAtMzksNiArMzksNyBAQA0KPiA+ID4gICAjaW5jbHVkZSAiaW8uaCIN
Cj4gPiA+ICAgI2luY2x1ZGUgImRlYnVnLmgiDQo+ID4gPiArI2luY2x1ZGUgIi4uL2hvc3QveGhj
aS1leHQtY2Fwcy5oIg0KPiA+ID4gICAjZGVmaW5lIERXQzNfREVGQVVMVF9BVVRPU1VTUEVORF9E
RUxBWQk1MDAwIC8qIG1zICovDQo+ID4gPiBAQCAtMTg4MiwxMCArMTg4Myw1NyBAQCBzdGF0aWMg
aW50IGR3YzNfZ2V0X2Nsb2NrcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gICAJcmV0dXJuIDA7
DQo+ID4gPiAgIH0NCj4gPiA+ICtzdGF0aWMgaW50IGR3YzNfcmVhZF9wb3J0X2luZm8oc3RydWN0
IGR3YzMgKmR3YykNCj4gPiANCj4gPiBJIHRoaW5rIGl0IG1heSBmaXQgYmV0dGVyIHRvIGxlYXZl
IHRoaXMgZnVuY3Rpb24gZGVmaW5pdGlvbiBpbiBob3N0LmMuDQo+ID4gQnV0IHlvdSBjYW4gYWxz
byBhcmd1ZSB0byBsZWF2ZSBpdCBoZXJlLiBMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluay4NCj4g
DQo+IEknZCBsaWtlIHRvIGtlZXAgaXQgaGVyZSBmb3Igbm93Lg0KPiANCj4gPiANCj4gPiA+ICt7
DQo+ID4gPiArCXZvaWQgX19pb21lbSAqYmFzZTsNCj4gPiA+ICsJdTggbWFqb3JfcmV2aXNpb247
DQo+ID4gPiArCXUzMiBvZmZzZXQ7DQo+ID4gPiArCXUzMiB2YWw7DQo+ID4gPiArDQo+ID4gPiAr
CS8qDQo+ID4gPiArCSAqIFJlbWFwIHhIQ0kgYWRkcmVzcyBzcGFjZSB0byBhY2Nlc3MgWEhDSSBl
eHQgY2FwIHJlZ3Mgc2luY2UgaXQgaXMNCj4gPiA+ICsJICogbmVlZGVkIHRvIGdldCBpbmZvcm1h
dGlvbiBvbiBudW1iZXIgb2YgcG9ydHMgcHJlc2VudC4NCj4gPiA+ICsJICovDQo+ID4gPiArCWJh
c2UgPSBpb3JlbWFwKGR3Yy0+eGhjaV9yZXNvdXJjZXNbMF0uc3RhcnQsDQo+ID4gPiArCQkgICAg
ICAgcmVzb3VyY2Vfc2l6ZSgmZHdjLT54aGNpX3Jlc291cmNlc1swXSkpOw0KPiA+ID4gKwlpZiAo
SVNfRVJSKGJhc2UpKQ0KPiA+IA0KPiA+IGlvcmVtYXAgcmV0dXJucyBOVUxMIG9uIGVycm9ycy4N
Cj4gPiANCj4gDQo+IENhbiB3ZSBrZWVwIHRoZSBhYm92ZSBmb3Igbm93IGlmIHRoZSB2MTQgc2Vy
aWVzIGdvZXMgd2VsbC4gSSdsbCBwb3N0IGEgcGF0Y2gNCj4gbGF0ZXIgZm9yIHRoaXMuIEluY2Fz
ZSBpdCB0dXJucyBvdXQgSSBuZWVkIHYxNSBJIHdpbGwgbWFrZSB0aGlzIGNoYW5nZSBpbg0KPiB2
MTUuDQoNClN1cmUuIEl0J3MgYSBtaW5vciBpc3N1ZSBhbmQgc2hvdWxkbid0IGhvbGQgYmFjayB0
aGlzIHNlcmllcy4NCg0KPiANCj4gPiA+ICsJCXJldHVybiBQVFJfRVJSKGJhc2UpOw0KPiA+ID4g
Kw0KPiA+ID4gKwlvZmZzZXQgPSAwOw0KPiA+ID4gKwlkbyB7DQo+ID4gPiArCQlvZmZzZXQgPSB4
aGNpX2ZpbmRfbmV4dF9leHRfY2FwKGJhc2UsIG9mZnNldCwNCj4gPiA+ICsJCQkJCQlYSENJX0VY
VF9DQVBTX1BST1RPQ09MKTsNCj4gPiA+ICsJCWlmICghb2Zmc2V0KQ0KPiA+ID4gKwkJCWJyZWFr
Ow0KPiA+ID4gKw0KPiA+ID4gKwkJdmFsID0gcmVhZGwoYmFzZSArIG9mZnNldCk7DQo+ID4gPiAr
CQltYWpvcl9yZXZpc2lvbiA9IFhIQ0lfRVhUX1BPUlRfTUFKT1IodmFsKTsNCj4gPiA+ICsNCj4g
PiA+ICsJCXZhbCA9IHJlYWRsKGJhc2UgKyBvZmZzZXQgKyAweDA4KTsNCj4gPiA+ICsJCWlmICht
YWpvcl9yZXZpc2lvbiA9PSAweDAzKSB7DQo+ID4gPiArCQkJZHdjLT5udW1fdXNiM19wb3J0cyAr
PSBYSENJX0VYVF9QT1JUX0NPVU5UKHZhbCk7DQo+ID4gPiArCQl9IGVsc2UgaWYgKG1ham9yX3Jl
dmlzaW9uIDw9IDB4MDIpIHsNCj4gPiA+ICsJCQlkd2MtPm51bV91c2IyX3BvcnRzICs9IFhIQ0lf
RVhUX1BPUlRfQ09VTlQodmFsKTsNCj4gPiA+ICsJCX0gZWxzZSB7DQo+ID4gPiArCQkJZGV2X3dh
cm4oZHdjLT5kZXYsDQo+ID4gPiArCQkJCSAidW5yZWNvZ25pemVkIHBvcnQgbWFqb3IgcmV2aXNp
b24gJWRcbiIsDQo+ID4gPiArCQkJCQkJCW1ham9yX3JldmlzaW9uKTsNCj4gPiA+ICsJCX0NCj4g
PiA+ICsJfSB3aGlsZSAoMSk7DQo+ID4gPiArDQo+ID4gPiArCWRldl9kYmcoZHdjLT5kZXYsICJo
cy1wb3J0czogJXUgc3MtcG9ydHM6ICV1XG4iLA0KPiA+ID4gKwkJZHdjLT5udW1fdXNiMl9wb3J0
cywgZHdjLT5udW1fdXNiM19wb3J0cyk7DQo+ID4gPiArDQo+ID4gPiArCWlvdW5tYXAoYmFzZSk7
DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiANCj4g
PiA+ICAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gPiAgIHsNCj4gPiA+ICAgCXN0cnVjdCBkZXZpY2UJCSpkZXYgPSAmcGRldi0+ZGV2Ow0K
PiA+ID4gICAJc3RydWN0IHJlc291cmNlCQkqcmVzLCBkd2NfcmVzOw0KPiA+ID4gKwl1bnNpZ25l
ZCBpbnQJCWh3X21vZGU7DQo+ID4gPiAgIAl2b2lkIF9faW9tZW0JCSpyZWdzOw0KPiA+ID4gICAJ
c3RydWN0IGR3YzMJCSpkd2M7DQo+ID4gPiAgIAlpbnQJCQlyZXQ7DQo+ID4gPiBAQCAtMTk2OSw2
ICsyMDE3LDIwIEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+ID4gICAJCQlnb3RvIGVycl9kaXNhYmxlX2Nsa3M7DQo+ID4gPiAgIAl9DQo+
ID4gPiArCS8qDQo+ID4gPiArCSAqIEN1cnJlbnRseSBvbmx5IERXQzMgY29udHJvbGxlcnMgdGhh
dCBhcmUgaG9zdC1vbmx5IGNhcGFibGUNCj4gPiA+ICsJICogc3VwcG9ydCBNdWx0aXBvcnQuDQo+
ID4gPiArCSAqLw0KPiA+ID4gKwlod19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01PREUoZHdjLT5o
d3BhcmFtcy5od3BhcmFtczApOw0KPiA+ID4gKwlpZiAoaHdfbW9kZSA9PSBEV0MzX0dIV1BBUkFN
UzBfTU9ERV9IT1NUKSB7DQo+ID4gPiArCQlyZXQgPSBkd2MzX3JlYWRfcG9ydF9pbmZvKGR3Yyk7
DQo+ID4gDQo+ID4gVGhlIGZ1bmN0aW9uIG5hbWUgaGVyZSBjYW4gYmUgcmV3b3JkZWQgYXMgaXQg
ZG9lcyBtb3JlIHRoYW4gcmVhZGluZyB0aGUNCj4gPiBwb3J0IGluZm8uIFBlcmhhcHMgZHdjM19n
ZXRfbnVtX3BvcnRzKCk/DQo+ID4gDQo+IEkgYW0gZmluZSBlaXRoZXIgd2F5cy4gSSdsbCBjaGFu
Z2UgdGhlIGZ1bmMgbmFtZSBpbiB2MTUuDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

